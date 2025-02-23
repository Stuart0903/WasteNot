


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/data/repositories/user/user_repo.dart';
import 'package:wastenot/features/authentication/models/user_model.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final userRepsitory = Get.put(UserRepository());

  ///Save user Record from any Registration provider
  Future<void>saveUserRecord(UserCredential? userCredentials)async{
    try{
      if(userCredentials!= null){
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
            profilePicture: userCredentials.user!.photoURL ?? ""
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
}