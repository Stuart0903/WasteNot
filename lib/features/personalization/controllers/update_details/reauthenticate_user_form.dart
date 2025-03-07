import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';

class ReauthenticateUserFormView extends StatelessWidget {
  const ReauthenticateUserFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const WNAppBar(title: Text('Re-Authenticate User'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(WNSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: WNValidators.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: WNTexts.email,
                  ),
                ),
                const SizedBox(height: WNSizes.spaceBtwInputFields),

                ///Password
                Obx(
                    ()=> TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value)=> WNValidators.validateEmptyText('Password', value),
                      decoration: InputDecoration(
                        labelText: WNTexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: ()=> controller.hidePassword.value =! controller.hidePassword.value,
                          icon: const Icon(Iconsax.eye_slash),
                        )
                      ),
                    )
                ),
                const SizedBox(height: WNSizes.spaceBtwSections),

                ///Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: ()=> controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')
                  )
                )

              ],
            )
          ),
        )
      )

    );
  }
}
