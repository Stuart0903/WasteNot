
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/login_signup/form_divider.dart';
import 'package:wastenot/common/widgets/login_signup/form_footer.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';


import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: WNSizes.appBarHeight, left: WNSizes.defaultSpace, right: WNSizes.defaultSpace, bottom: WNSizes.defaultSpace),
          child: Column(
            children: [
              ///Header with Logo, logo header, logo sub header
              const WNLoginHeader(),

              ///Form
              const WNLoginForm(),

              ///Divider
              WNLoginDivider(dividerText: WNTexts.orSignInWith.capitalize!,),

              const SizedBox(height: WNSizes.spaceBtwSections,),

              ///Footer
              WNLoginFooter(),

            ],
          ),
        ),
      ),
    );
  }
}








