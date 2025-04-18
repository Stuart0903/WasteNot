
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart ';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/authentication/controllers/signUp/signup_controller.dart';
import 'package:wastenot/features/authentication/views/login/login_view.dart';
import 'package:wastenot/features/authentication/views/signup/verify_email.dart';
import 'package:wastenot/features/onboarding/views/onboarding_view.dart';
import 'package:wastenot/navigation_menu.dart';
import 'package:wastenot/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';


class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  ///Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  ///Call from main.dart on app launch
  @override
  void onReady(){
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  ///Function to Show Relevant Screen
  screenRedirect() async{
    final user = _auth.currentUser;
    if (user!= null){
      if (user.emailVerified){
        Get.offAll(()=> const NavigationMenu());
      }else{
        Get.offAll(()=> VerifyEmailView(email: _auth.currentUser?.email,));
      }
    }else{
      //Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.off(() => const LoginView())
          : Get.off(()=> const OnBoardingView());
    }

  }


  /*----------------------------- Email & Password sign -in --------------------------*/

///Email Authentication - Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password)async{
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw WNFirebaseException(e.code).message;
    }on FormatException catch (e){
      throw const WNFormatException();
    }on PlatformException catch (e){
      throw WNPlatformException(e.code).message;
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

///Register
  Future<UserCredential> registerWithEmailandPassword(String email, String password)async{
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('UserCredential: ${userCredential.user}'); // Log the response
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw WNFirebaseException(e.code).message;
    }on FormatException catch (_){
      throw const WNFormatException();
    }on PlatformException catch (e){
      throw WNPlatformException(e.code).message;
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  /// [EmailVerification] - Mail verification
  Future<void> sendEmailVerification()async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch (e){
      throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw WNFirebaseException(e.code).message;
    }on FormatException catch (e){
      throw const WNFormatException();
    }on PlatformException catch (e){
      throw WNPlatformException(e.code).message;
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }


  /// -FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email)async{
      try{
        await _auth.sendPasswordResetEmail(email: email);
      }on FirebaseAuthException catch (e){
        throw WNFirebaseAuthException(e.code).message;
      }on FirebaseException catch (e){
        throw WNFirebaseException(e.code).message;
      }on FormatException catch (e){
        throw const WNFormatException();
      }on PlatformException catch (e){
        throw WNPlatformException(e.code).message;
      }catch (e){
        throw 'Something went wrong, Please try again';
      }
    }

  Future<void> reAuthenticateWithEmailAndPassword(String email, String password)async{
    try{
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch (e){
    throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
    throw WNFirebaseException(e.code).message;
    }on FormatException catch (e){
    throw const WNFormatException();
    }on PlatformException catch (e){
    throw WNPlatformException(e.code).message;
    }catch (e){
    throw 'Something went wrong, Please try again';
    }
  }

  Future<void> deleteAccount()async{
    try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    }on FirebaseAuthException catch (e){
      throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw WNFirebaseException(e.code).message;
    }on FormatException catch (e){
      throw const WNFormatException();
    }on PlatformException catch (e){
      throw WNPlatformException(e.code).message;
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }


  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginView());
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseAuthException(e.code).message;
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


  /// Verify the current password (for Email/Password users)
  Future<bool> verifyCurrentPassword(String currentPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in';

      // Create a credential with the current password
      final credential = EmailAuthProvider.credential(
        email: user.email!, // Use the user's email
        password: currentPassword,
      );

      // Reauthenticate the user with the credential
      await user.reauthenticateWithCredential(credential);
      return true; // Password is correct
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Update the password (for Email/Password users)
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in';

      // Update the password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Link Google account with Email/Password credential (for Google Sign-In users)
  Future<void> linkGoogleAccountWithPassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in';

      // Create a credential with the user's email and new password
      final credential = EmailAuthProvider.credential(
        email: user.email!, // Use the user's email
        password: newPassword,
      );

      // Link the credential to the user's account
      await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw WNFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Check if the user signed in with Google
  bool isGoogleUser() {
    final user = _auth.currentUser;
    if (user == null) return false;

    // Check if the user has a Google provider
    return user.providerData.any((userInfo) => userInfo.providerId == 'google.com');
  }



















  /// [GoogleAuthentication] - Google
  Future<UserCredential?> signInWithGoogle()async{
    try{
      //Trigger the authentication Flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =   await userAccount?.authentication;

      //Create a new credentials
      final credentials= GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //once sign in, return the User Credentials
      return await _auth.signInWithCredential(credentials);

    }on FirebaseAuthException catch (e){
      throw WNFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw WNFirebaseException(e.code).message;
    }on FormatException catch (e){
      throw const WNFormatException();
    }on PlatformException catch (e){
      throw WNPlatformException(e.code).message;
    }catch (e){
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

/// [FaceBookAuthentication] - Facebook







///
///












}
