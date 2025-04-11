import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/deposit_item_model.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/deposit_model.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_detail_model.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';

class DepositRepository extends GetxController {
  static DepositRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add a new deposit
  Future<void> addDeposit(DepositModel deposit) async {
    try {
      await _db.collection("deposits").doc(deposit.depositId).set(
          deposit.toJson());
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Add a new deposit item
  Future<void> addDepositItem(DepositItem item) async {
    try {
      await _db.collection("deposit_items").doc(item.itemId).set(item.toJson());
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all deposits for a user
  Future<List<DepositModel>> getUserDeposits(String userId) async {
    try {
      final querySnapshot = await _db.collection("deposits")
          .where('user_id', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => DepositModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error retrieving user deposits';
    }
  }


  /// Fetch all deposits for a user
  Future<List<DepositModel>> fetchUserDeposits(String userId) async {
    try {
      final querySnapshot = await _db
          .collection("deposits")
          .where("user_id", isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => DepositModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetch all items for a specific deposit
  Future<List<DepositItem>> fetchDepositItems(String depositId) async {
    try {
      final querySnapshot = await _db
          .collection("deposit_items")
          .where("deposit_id", isEqualTo: depositId)
          .get();
      return querySnapshot.docs.map((doc) => DepositItem.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<Map<String, int>> fetchItemQuantities(String userId) async {
    try {
      // Fetch all deposits for the user
      final deposits = await fetchUserDeposits(userId);

      // Initialize a map to store total quantities of materials
      Map<String, int> quantitiesByMaterial = {
        'plastic': 0,
        'glass': 0,
        'can': 0,
      };

      // Loop through each deposit
      for (var deposit in deposits) {
        // Fetch items for the current deposit
        final items = await fetchDepositItems(deposit.depositId!);

        // Aggregate quantities of materials
        for (var item in items) {
          // print('Processing item: $item.itemId');
          // Ensure the material type is valid
          if (quantitiesByMaterial.containsKey(item.materialType)) {
            quantitiesByMaterial[item.materialType] = (quantitiesByMaterial[item.materialType] ?? 0) + item.quantity;
          }
        }
      }

      print('Final quantities by material: $quantitiesByMaterial'); // Log final quantities
      return quantitiesByMaterial;
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  Future<void> addQRDetails(QRDetailModel qrDetail) async {
    try {
      await _db.collection("qr_scans").doc(qrDetail.uuid).set(qrDetail.toJson());
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<String>> fetchQrScanDocumentIds() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('qr_scans')
          .get();

      // Extract just the document IDs
      final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();

      // Print to console
      print('Fetched ${documentIds.length} QR scan document IDs:');
      documentIds.forEach(print); // Prints each ID on a new line

      return documentIds;
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw 'Failed to fetch document IDs: ${e.message}';
    } catch (e) {
      print('Error: $e');
      throw 'Something went wrong';
    }
  }
}