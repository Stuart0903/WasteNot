
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/success_screen/success_screen.dart';

import 'dart:async';

import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    setTimerForAutoRedirect();
    sendEmailVerification();
    super.onInit();
  }

  /// Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      WNLoaders.successSnackBar(title: 'Email sent', message: 'Please Check your inbox and verify the email. ');
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

/// Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration( seconds: 1), (timer)async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified?? false){
        timer.cancel();
        Get.off(
            () => SuccessScreen(
                image: WNImages.loadingAnimation,
                title: WNTexts.createAccountTitle,
                subTitle: WNTexts.createAccountSubTitle,
                onPressed: ()=> AuthenticationRepository.instance.screenRedirect())
        );
      }

    });
  }

/// Manually Check if Email Verified
  checkEmailVerificationStatus()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser!= null && currentUser.emailVerified){
      Get.off(
          ()=> SuccessScreen(
              image: WNImages.successEmail,
              title: WNTexts.createAccountTitle,
              subTitle: WNTexts.createAccountSubTitle,
              onPressed: ()=> AuthenticationRepository.instance.screenRedirect())
      );
    }
  }
}

