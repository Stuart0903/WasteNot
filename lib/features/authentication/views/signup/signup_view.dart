
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/login_signup/form_divider.dart';
import 'package:wastenot/common/widgets/login_signup/form_footer.dart';
import 'package:wastenot/features/authentication/views/signup/widgets/signup_form.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';


class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark =WNHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
              ///title
          Text(WNTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: WNSizes.spaceBtwSections,),

            ///form
            const WNsignupform(),
            const SizedBox(height: WNSizes.spaceBtwInputFields,),


            /// Divider
            WNLoginDivider(dividerText: WNTexts.orSignInWith.capitalize!),
            const SizedBox(height: WNSizes.spaceBtwInputFields,),

            /// Social Buttons
            const WNLoginFooter(),
            const SizedBox(height: WNSizes.spaceBtwInputFields,),


          ],
        )),
      ),

    );
  }
}


