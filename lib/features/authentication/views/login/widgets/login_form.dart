
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';


class WNLoginForm extends StatelessWidget {
  const WNLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child:
    Padding(
      padding: const EdgeInsets.symmetric(vertical: WNSizes.spaceBtwSections +10),
      child: Column(
        children: [
          ///Email
          TextFormField(
            decoration:InputDecoration(
              prefixIcon: Icon(CupertinoIcons.mail),
              labelText: WNTexts.email,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),
          ///Password
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.padlock_solid),
                labelText: WNTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields/2,),

          ///Remember Me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value){}),
                  const Text(WNTexts.rememberMe)
                ],
              ),
              // TextButton(onPressed: () =>Get.to(() => const ForgotPassword()), child: Text(WNTexts.forgetPassword))
            ],
          ),
          const SizedBox(height: WNSizes.spaceBtwSections,),

          ///Sign In Button
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text(WNTexts.signIn))),
          const SizedBox(height: WNSizes.spaceBtwItems),
          ///Create Account Button
          // SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const SignupView()) {}, child: Text(WNTexts.createAccount)))
          SizedBox(
            width: double.infinity,
            // child: OutlinedButton(onPressed: () => Get.to(SignupView()), child: const Text(WNTexts.createAccount)),

          )
        ],

      ),
    )
    );
  }
}