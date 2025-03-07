
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:wastenot/features/authentication/views/password_configuration/reset_password.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/validators/validation.dart';

import '../../../../utils/constants/text_strings.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: WNAppBar(),
      body:  Padding(
          padding: EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Heading
            Text(WNTexts.forgetPasswordTitle, style:Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: WNSizes.spaceBtwItems,),
            Text(WNTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: WNSizes.spaceBtwSections * 2),



            ///Text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: WNValidators.validateEmail,
                decoration: InputDecoration(labelText: WNTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections * 2),



            ///Submit Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(WNTexts.submit)))
          ],
        ),
      ) ,
    );
  }
}


