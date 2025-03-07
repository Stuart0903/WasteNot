// File: lib/features/nav_menu/qr_scanner/controller/qr_scanner_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/qr_detailPage.dart';
import '../model/qr_scanner_model.dart';


class QRScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  final RxString result = 'Scan a QR code'.obs;
  final RxBool isScanned = false.obs;
  final RxBool isProcessing = false.obs;
  final RxMap<String, Map<String, dynamic>> jsonData = <String, Map<String, dynamic>>{}.obs;

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
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
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
      // Attempt to decode the JSON data
      List<dynamic> parsedJson = jsonDecode(data);

      // Validate the JSON structure:
      // Each element should be a Map containing both 'class' and 'count' keys.
      bool isValidFormat = parsedJson.every((element) {
        return element is Map &&
            element.containsKey('class') &&
            element.containsKey('count');
      });

      // If the JSON format is invalid, show a warning and exit.
      if (!isValidFormat) {
        Get.snackbar(
          'Invalid QR Code',
          'QR does not contain valid recycling data',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Clear previous data and process the new QR data.
      jsonData.clear();
      for (var e in parsedJson) {
        jsonData[e['class']] = {'count': (e['count'] as num).toInt()};
      }

      // Mark the scan as complete and pause the camera.
      isScanned.value = true;
      controller?.pauseCamera();

      // Navigate to detail page
      Get.to(() => QRDetailPage(scannedData: jsonData));

    } catch (e) {
      // If decoding fails or any error occurs, display an error message.
      Get.snackbar(
        'Invalid QR Code',
        'QR does not contain valid JSON data',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void resetScan() {
    isScanned.value = false;
    result.value = 'Scan a QR code';
    jsonData.clear();
    controller?.resumeCamera();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}