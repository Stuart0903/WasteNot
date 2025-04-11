import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/shop/model/redeemption_model.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';

class RedeemptionRepo extends GetxController {
  static RedeemptionRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  ///Function to fetch VoucherDetails Based on category ID
  Future<List<VoucherInfoModel>> fetchVoucherDetails(String categoryID) async {
    try {
      // Fetch the collection of voucher info
      final querySnapshot = await _db.collection("voucher_details")
          .where("category_id", isEqualTo: categoryID).get();
      // Convert each document to VoucherInfoModel
      return querySnapshot.docs.map((doc) => VoucherInfoModel.fromSnapshot(doc)).toList();
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



  /// Function to fetch VoucherInfoModel based on userID
  Future<List<VoucherInfoModel>> fetchVoucherInfoDetails() async {
    try {
      // Fetch the collection of voucher info
      final querySnapshot = await _db.collection("voucher_info").
      where('status', isEqualTo: 'active').get();

      // Convert each document to VoucherInfoModel
      return querySnapshot.docs.map((doc) => VoucherInfoModel.fromSnapshot(doc)).toList();
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

  ///Function to add Redeemption after user redeem
  Future<void>saveRedeemption(RedeemptionModel redeemption)async{
    try {
      await _db.collection("redemption").doc(redeemption.id).set(redeemption.toJson());
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

  Future<void>updateVoucherStatus(String voucherId) async {
    try {
      _db.collection("voucher_info").doc(voucherId).update({
        'status': 'reserved'
      });
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

  Future<List<VoucherInfoModel>> getUserVoucherInfo(String userId) async {
    try {
      final querySnapshot = await _db.collection("redemption")
          .where('user_Id', isEqualTo: userId)
          .where('is_Redeemed', isEqualTo: false)
          .get();

      final now = DateTime.now();

      final validDocs = querySnapshot.docs.where((doc) {
        final expiresAtStr = doc['expires_At'] as String;
        final expiresAt = DateTime.tryParse(expiresAtStr);
        if (expiresAt == null) return false;
        return expiresAt.isAfter(now);
      }).toList();

      if (validDocs.isEmpty) {
        throw Exception('No valid redemption records found for user $userId');
      }

      final voucherIds = validDocs.map((doc) => doc['voucher_Id'] as String).toList();

      List<VoucherInfoModel> voucherModels = [];

      for (String voucherId in voucherIds) {
        final voucherDocSnapshot = await _db.collection('voucher_info')
            .doc(voucherId)
            .get();

        if (voucherDocSnapshot.exists) {
          voucherModels.add(VoucherInfoModel.fromSnapshot(voucherDocSnapshot));
          print("Voucher found: ${voucherDocSnapshot.data()}");
        } else {
          print("Voucher with ID $voucherId does not exist.");
        }
      }

      print("Fetched Voucher Models: $voucherModels");

      return voucherModels;

    } on FirebaseException catch (e) {
      print("🔥 FirebaseException: ${e.code} - ${e.message}");
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      print("🔥 Unknown Error: $e");
      throw 'Something went wrong. Please try again';
    }
  }


}
