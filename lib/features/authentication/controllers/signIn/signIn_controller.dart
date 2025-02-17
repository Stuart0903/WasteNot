import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController{
  ///Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


}