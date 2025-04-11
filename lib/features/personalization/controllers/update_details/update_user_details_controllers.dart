import 'package:flutter/material.dart';
import 'package:get/get.dart%20';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/profile.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class UpdateUserDetailsControllers extends GetxController{
  static UpdateUserDetailsControllers get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController();
  final dateOfBirth = TextEditingController();
  final address = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  // Form Keys
  final GlobalKey<FormState> updateFullNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateUsernameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateGenderFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateDateOfBirthFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateAddressFormKey = GlobalKey<FormState>();


  /// Initialize user data when the controller is created
  @override
  void onInit() {
    initializeUserData();
    super.onInit();
  }

  /// Fetch user record and initialize controllers
  Future<void> initializeUserData() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    username.text = userController.user.value.userName;
    phoneNumber.text = userController.user.value.phoneNumber;
    gender.text = userController.user.value.gender;
    dateOfBirth.text = userController.user.value.dateOfBirth;
    address.text = userController.user.value.address;
  }


  Future<void> updateFullName()async{
    try{
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        // WNFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!updateFullNameFormKey.currentState!.validate()){
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

  /// Update Username
  Future<void> updateUsername() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateUsernameFormKey.currentState!.validate()) return;

      // Update username in Firebase
      Map<String, dynamic> data = {'UserName': username.text.trim()};
      await userRepository.updateSingleField(data);

      // Update the Rx User value
      userController.user.value.userName = username.text.trim();

      // Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your username has been updated');

      Get.off(() => const ProfileView());
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }


  /// Update Phone Number
  Future<void> updatePhoneNumber() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updatePhoneNumberFormKey.currentState!.validate()) return;

      // Update phone number in Firebase
      Map<String, dynamic> data = {'PhoneNumber': phoneNumber.text.trim()};
      await userRepository.updateSingleField(data);

      // Update the Rx User value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      // Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your phone number has been updated');

      Get.off(() => const ProfileView());
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Update Gender
  Future<void> updateGender() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateGenderFormKey.currentState!.validate()) return;

      // Update gender in Firebase
      Map<String, dynamic> data = {'Gender': gender.text.trim()};
      await userRepository.updateSingleField(data);

      // Update the Rx User value
      userController.user.value.gender = gender.text.trim();

      // Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your gender has been updated');

      Get.off(() => const ProfileView());
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Update Date of Birth
  Future<void> updateDateOfBirth() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateDateOfBirthFormKey.currentState!.validate()) return;

      // Update date of birth in Firebase
      Map<String, dynamic> data = {'DateOfBirth': dateOfBirth.text.trim()};
      await userRepository.updateSingleField(data);

      // Update the Rx User value
      userController.user.value.dateOfBirth = dateOfBirth.text.trim();

      // Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your date of birth has been updated');

      Get.off(() => const ProfileView());
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }


  /// Update Address
  Future<void> updateAddress() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateAddressFormKey.currentState!.validate()) return;

      // Update address in Firebase
      Map<String, dynamic> data = {'Address': address.text.trim()};
      await userRepository.updateSingleField(data);

      // Update the Rx User value
      userController.user.value.address = address.text.trim();

      // Show Success Message
      WNLoaders.successSnackBar(title: 'Success', message: 'Your address has been updated');

      Get.off(() => const ProfileView());
    } catch (e) {
      WNLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}