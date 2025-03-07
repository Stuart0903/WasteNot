import 'package:flutter/material.dart';
import 'package:get/get.dart%20';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/profile.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  ///init user when Home Screen appears
  @override
  void onInit(){
    initializeName();
    super.onInit();
  }

  ///Fetch user record
  Future<void>initializeName() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName()async{
    try{
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        // WNFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        return;
      }

      // Update user's first and last Name in the Firebase
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your name has been updated');

      Get.off(()=> const ProfileView());

    }catch(e){
      WNLoaders.errorSnackBar(title: 'Error', message:e.toString());
    }
  }
}