import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/authentication/models/user_model.dart';
import 'package:wastenot/features/authentication/views/login/login_view.dart';
import 'package:wastenot/features/personalization/controllers/update_details/reauthenticate_user_form.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepsitory = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit(){
    super.onInit();
    fetchUserRecord();
  }

  ///Fetch user record
  Future<void> fetchUserRecord()async{
    try{
      final user = await userRepsitory.fetchUserDetails();
      this.user(user);
    }catch(e){
      user(UserModel.empty());
    }
  }

  ///Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try{
      if(userCredentials != null){
        //Convert Name to First and Last Name
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName?? '');

        //Map Data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
          userName: username,
          email: userCredentials.user!.email ?? "",
          phoneNumber: userCredentials.user!.phoneNumber ?? "",
          profilePicture: userCredentials.user!.photoURL ?? "",
          gender: "",
          dateOfBirth: "",
          address: "",
        );

        //save user data
        await userRepsitory.saveUserRecord(user);
      }
    }catch(e){
      WNLoaders.warningSnackBar(
        title: 'Data not Saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile',
      );
    }
  }

  ///Delete Account Warning
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(WNSizes.md),
      title: 'Delete Account',
      middleText:'Are you sure want to delete your account permanently? This action is not reversible and all your data will be removed permanently',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: WNSizes.lg), child: Text('Delete'))
      ),
      cancel: OutlinedButton(
          onPressed: ()=> Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
      )
    );
  }

  ///Delete User Account
  void deleteUserAccount() async{
    try{
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e)=> e.providerId).first;
      if(provider.isNotEmpty){
        //Re Verify Auth Email
        if (provider == 'google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          Get.offAll(()=> const LoginView());
        }else if(provider == 'password'){
          Get.to(()=> const ReauthenticateUserFormView());
        }
      }
    } catch(e){
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async{
    try{
      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return;
      }
      if (!reAuthFormKey.currentState!.validate()){
        WNFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      WNFullScreenLoader.stopLoading();
      Get.offAll(()=> const LoginView());
    }catch(e){
      WNFullScreenLoader.stopLoading();
      WNLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }





}

