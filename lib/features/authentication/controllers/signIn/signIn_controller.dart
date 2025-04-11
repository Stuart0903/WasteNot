import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20';
import 'package:get_storage/get_storage.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class SignInController extends GetxController{
  ///Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());





  ///Email and password sign In
  Future<void>emailAndPasswordSignIn() async{
    try{
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        WNFullScreenLoader.stopLoading();
        return;
      }

      //Start loading
      WNFullScreenLoader.openLoadingDialog('Logging in....', WNImages.fullScreenloader);

      // Form Validation
      if (loginFormKey.currentState == null || !loginFormKey.currentState!.validate()) {
        WNFullScreenLoader.stopLoading();
        return;
      }

      //Save Data if Remember Me is selected
      if(rememberMe.value){
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      //Login user using Email and password authentication
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove Loader
      WNFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(title: "Oh Shoot!!", message: e.toString());
    }
  }

  ///GOogle signIn Authentication
  Future<void>googleSignIn()async{
    try{

      WNFullScreenLoader.openLoadingDialog('Logging you in....', WNImages.fullScreenloader);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        WNFullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // //Save User Record
      // await userController.saveUserRecord(userCredentials);

      // Check if user already exists in Firestore
      final userRepo = UserRepository.instance;
      final userDoc = await userRepo.fetchUserDetails();

      if (userDoc.id.isEmpty) {
        // User does not exist, save new user record
        await userController.saveUserRecord(userCredentials);
      } else {
        // User exists, update local state with existing data
        userController.user(userDoc);
      }

      //Remove loaders
      WNFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      //Remove loaders
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(title: 'Oh Shoot', message: e.toString());
    }
  }

}