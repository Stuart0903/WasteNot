import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/features/authentication/views/password_configuration/reset_password.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  ///Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///send Reset Password Email
  sendPasswordResetEmail()async{
    try {
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WNFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        WNFullScreenLoader.stopLoading();
        return;
      }

      //Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      WNFullScreenLoader.stopLoading();

      //Show Success Message
      WNLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password');

      // Redirect
      Get.to(()=> ResetPasswordView(email: email.text.trim()));


    }catch(e){
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  resendPasswordResentEmail(String email)async {
    try {
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WNFullScreenLoader.stopLoading();
        return;
      }


      //Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove Loader
      WNFullScreenLoader.stopLoading();

      //Show Success Message
      WNLoaders.successSnackBar(title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password');
    } catch (e) {
      WNFullScreenLoader.stopLoading();
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}