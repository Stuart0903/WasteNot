import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/points/deposit_repo.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_detail_model.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/qr_detailPage.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';
import '../model/qr_scanner_model.dart';
import "package:google_ml_kit/google_ml_kit.dart" as mlkit;

class QRScannerController extends GetxController {
  static QRScannerController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DepositRepository _depositRepo = Get.put(DepositRepository());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  final RxString result = 'Scan a QR code'.obs;
  final RxBool isScanned = false.obs;
  final RxBool isProcessing = false.obs;
  final RxMap<String, Map<String, dynamic>> jsonData = <String, Map<String, dynamic>>{}.obs;
  final RxString qrId = ''.obs;

  final ImagePicker _picker = ImagePicker();

  int get totalPoints => jsonData.entries.fold(
    0,
        (sum, entry) =>
    sum + ((entry.value['count'] as int) * RecyclingData.getPointsPerItem(entry.key)),
  );

  Future<void> pickImageFromGallery() async {
    isProcessing.value = true;
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        isProcessing.value = false;
        return;
      }

      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner([mlkit.BarcodeFormat.qrCode]);
      final barcodes = await barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        processQRData(barcodes.first.rawValue ?? '');
      } else {
        Get.snackbar(
          'No QR Code Found',
          'The image does not contain a valid QR code',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
      barcodeScanner.close();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process image: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isProcessing.value = false;
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanned.value && scanData.code != null) {
        processQRData(scanData.code!);
      }
    });
  }

  void processQRData(String data) {
    try {
      // Step 1: Decode the JSON string
      final decodedData = jsonDecode(data);

      // Step 2: Validate root is a List with exactly one item
      if (decodedData is! List || decodedData.length != 1) {
        throw FormatException('QR data must be a single-item array');
      }

      // Step 3: Extract the main object
      final qrObject = decodedData.first as Map<String, dynamic>;

      // Step 4: Validate required fields
      if (!qrObject.containsKey('qr_id') || !qrObject.containsKey('items')) {
        throw FormatException('Missing required fields: qr_id or items');
      }

      // Step 5: Validate and extract QR ID
      final qrIdValue = qrObject['qr_id']?.toString();
      if (qrIdValue == null || qrIdValue.isEmpty) {
        throw FormatException('qr_id cannot be empty');
      }

      // Step 6: Validate items array
      final items = qrObject['items'] as List;
      if (items.isEmpty) {
        throw FormatException('Items array cannot be empty');
      }

      // Step 7: Process each item
      final processedItems = <String, Map<String, dynamic>>{};
      for (var item in items.cast<Map<String, dynamic>>()) {
        if (item['class'] == null || item['count'] == null) {
          throw FormatException('Each item must have class and count');
        }

        final count = item['count'] is int ? item['count'] as int :
        item['count'] is double ? (item['count'] as double).toInt() :
        throw FormatException('Count must be a number');

        if (count <= 0) {
          throw FormatException('Count must be positive');
        }

        processedItems[item['class'].toString()] = {'count': count};
      }

      // Step 8: Update state
      qrId.value = qrIdValue;
      jsonData.assignAll(processedItems);
      isScanned.value = true;
      controller?.pauseCamera();

      // Step 9: Navigate to detail page
      Get.to(() => QRDetailPage(
        scannedData: jsonData,
        qrId: qrId.value,
      ));

    } on FormatException catch (e) {
      _showError('Invalid Format', e.message);
    } catch (e) {
      _showError('Processing Error', 'Failed to decode QR data');
    }
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    resetScan();
  }

  void resetScan() {
    isScanned.value = false;
    result.value = 'Scan a QR code';
    jsonData.clear();
    qrId.value = '';
    controller?.resumeCamera();
  }

  // New method to check if QR is duplicate
  Future<bool> isQrDuplicate() async {
    try {
      if (qrId.value.isEmpty) return false;
      final existingIds = await _depositRepo.fetchQrScanDocumentIds();
      print("exisitingID: $existingIds");
      return existingIds.contains(qrId.value);
    } catch (e) {
      throw 'Failed to verify QR code: ${e.toString()}';
    }
  }

  Future<void> qrdetail() async {
    try {
      // Start Loading
      WNFullScreenLoader.openLoadingDialog(
          'We are processing your information', WNImages.fullScreenloader);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WNFullScreenLoader.stopLoading();
        WNLoaders.errorSnackBar(
            title: 'No Internet',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Get Current User ID
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) {
        WNFullScreenLoader.stopLoading();
        WNLoaders.errorSnackBar(
            title: 'Authentication Error',
            message: 'User not found. Please log in again.');
        return;
      }

      // Ensure qrId.value is not empty
      if (qrId.value.isEmpty) {
        WNFullScreenLoader.stopLoading();
        WNLoaders.errorSnackBar(
            title: 'QR Code Error',
            message: 'Invalid QR code. Please try again.');
        return;
      }

      // Create QRDetailModel instance
      final qrdetail = QRDetailModel(
        uuid: qrId.value,
        user_id: userId,
        scanned_at: DateTime.now(),
      );

      // Save QR details to Firestore
      await _depositRepo.addQRDetails(qrdetail);

      // Stop Loading and Show Success Message
      WNFullScreenLoader.stopLoading();
    } catch (e) {
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(
          title: 'Error', message: e.toString());
    }
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }




}