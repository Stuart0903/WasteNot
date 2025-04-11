
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/features/authentication/controllers/signUp/verifyEmail_controller.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, this.email});
  final String? email;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(WNSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(image: const AssetImage('assets/images/verification_images/verifyEmail.png'), width: WNHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: WNSizes.spaceBtwSections,),

              ///Title and Subtitile
              Text(WNTexts.verifyEmailTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwItems,),
              Text(email?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwItems,),
              Text(WNTexts.verifyEmailSubtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: WNSizes.spaceBtwSections),

              ///Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                child: const Text("Verify"),
                )
              ),
              const SizedBox(height: WNSizes.spaceBtwItems,),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text(WNTexts.resendEmail)),)

            ],
          ),
        ),
      ),
    );
  }
}

