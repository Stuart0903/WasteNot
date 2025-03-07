import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20';
import 'package:get_storage/get_storage.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
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
      //Start loading
      // WNFullScreenLoader.openLoadingDialog('Logging you in... ', WNImages.loadingAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        WNFullScreenLoader.stopLoading();
        return;
      }

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
      WNLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  ///GOogle signIn Authentication
  Future<void>googleSignIn()async{
    try{
      WNFullScreenLoader.openLoadingDialog('Logging you in....', WNImages.loadingAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        WNFullScreenLoader.stopLoading();
        return;
      }
      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Save User Record
      await userController.saveUserRecord(userCredentials);

      //Remove loaders
      WNFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      //Remove loaders
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}