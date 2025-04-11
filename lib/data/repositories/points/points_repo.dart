import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart%20';
import 'package:get_storage/get_storage.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/user_point_model.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';

class PointRepository extends GetxController{
  static PointRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get Authenticated User Data
  User? get authUser => _auth.currentUser;


  Future<void>saveUserPoint(UserPoint userPoint) async {
    try {
      // print("Saving Point: ${userPoint.toJson()}");
      await _db.collection("User Points").doc(userPoint.pointId).set(
          userPoint.toJson());
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

  Future<void> updateUserPoint(UserPoint updatedUserPoint) async {
    try {
      await _db.collection("User Points").doc(updatedUserPoint.pointId).update(updatedUserPoint.toJson());
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

  /// Get user's current points
  Future<UserPoint?> getUserPoints(String userId) async {
    try {
      final querySnapshot = await _db.collection("User Points")
          .where('user_id', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return UserPoint.fromSnapshot(querySnapshot.docs.first);
      }
      return null;
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error retrieving user points';
    }
  }













}