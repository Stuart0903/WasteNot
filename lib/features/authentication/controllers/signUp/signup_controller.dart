
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/authentication/models/user_model.dart';
import 'package:wastenot/features/authentication/views/signup/verify_email.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final privaryPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();




  /// SignUp
  void signup() async{
    try{
      //Start Loading
      WNFullScreenLoader.openLoadingDialog('We are processing your information', WNImages.loadingAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        WNFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!signupFormkey.currentState!.validate()){
        return;
      }

      //Privacy Policy check
      if(!privaryPolicy.value){
        WNLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
          message: 'In order to create an account, you must accpet the Privacy Policy & Terms of Use'
        );
        return;
      }

      //Register User in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailandPassword(email.text.trim(), password.text.trim());

      //Save Authentication userdata in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Show success Message
      WNLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue');

      //Navigate to Verify Email Screen
      Get.to(()=> VerifyEmailView(email: email.text.trim(),));



    }catch(e){
      WNFullScreenLoader.stopLoading();

      WNLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

    }
    }
  }
