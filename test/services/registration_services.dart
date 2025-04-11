import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:wastenot/features/authentication/models/user_model.dart';
import 'package:wastenot/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  UserRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore db,
  }) : _auth = auth, _db = db;

  Future<UserCredential> registerWithEmailandPassword(String email, String password) async {
    try {
      // Add input validation
      if (email.isEmpty) {
        throw const FormatException('Email cannot be empty');
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw const FormatException('Invalid email format');
      }
      if (password.isEmpty) {
        throw const FormatException('Password cannot be empty');
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('UserCredential: ${userCredential.user}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Add input validation
      if (email.isEmpty) {
        throw const FormatException('Email cannot be empty');
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw const FormatException('Invalid email format');
      }
      if (password.isEmpty) {
        throw const FormatException('Password cannot be empty');
      }

      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WNFormatException();
    } on PlatformException catch (e) {
      throw WNPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      print("Saving User: ${user.toJson()}");
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

}