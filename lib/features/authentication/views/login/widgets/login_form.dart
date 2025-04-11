
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/authentication/controllers/signIn/signIn_controller.dart';
import 'package:wastenot/features/authentication/views/password_configuration/forgot_password.dart';
import 'package:wastenot/features/authentication/views/signup/signup_view.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';


class WNLoginForm extends StatelessWidget {
  const WNLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Form(
      key: controller.loginFormKey,
        child:
    Padding(
      padding: const EdgeInsets.symmetric(vertical: WNSizes.spaceBtwSections +10),
      child: Column(
        children: [
          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => WNValidators.validateEmail(value),
            decoration:InputDecoration(
                prefixIcon: Icon(CupertinoIcons.mail),
                labelText: WNTexts.email,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),
          ///Password
          Obx(
                ()=> TextFormField(
              controller: controller.password,
              validator: (value) => WNValidators.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: WNTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: ()=> controller.hidePassword.value =!controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value? Iconsax.eye_slash : Iconsax.eye),

                  ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields/2,),

          ///Remember Me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                          ()=>
                      Checkbox(
                          value: controller.rememberMe.value,
                          onChanged:(value) => controller.rememberMe.value =! controller.rememberMe.value),
                  ),
                  const Text(WNTexts.rememberMe)
                ],
              ),
              TextButton(onPressed: () =>Get.to(() => const ForgotPassword()), child: Text(WNTexts.forgetPassword))
            ],
          ),
          const SizedBox(height: WNSizes.spaceBtwSections,),

          ///Sign In Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()=> controller.emailAndPasswordSignIn(),
                  child: Text(WNTexts.signIn))),
          const SizedBox(height: WNSizes.spaceBtwItems),

          ///Create Account Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(onPressed: () => Get.to(SignupView()), child: const Text(WNTexts.createAccount)),

          )
        ],

      ),
    )
    );
  }
}