
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:wastenot/features/authentication/views/login/login_view.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class ResetPasswordView extends StatelessWidget {
  const  ResetPasswordView({super.key, required this.email});

  final String email;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(WNSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(image: const AssetImage(WNImages.deliveredImageIllustration), width: WNHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: WNSizes.spaceBtwSections,),

              ///Title and Subtitile
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwItems,),
              Text(WNTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwItems,),
              Text(WNTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwSections),

              ///Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.offAll(()=> const LoginView()), child: const Text(WNTexts.done)),),
              const SizedBox(height: WNSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=> ForgetPasswordController.instance.resendPasswordResentEmail(email), child: const Text(WNTexts.resendEmail)),),

            ],
          ),

        ),
      )
    );
  }
}

