
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/authentication/controllers/signUp/signup_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';


class WNTermsAndConditioncheckbox extends StatelessWidget {
  const WNTermsAndConditioncheckbox({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    final dark = WNHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox( width: 20, height: 24,
            child: Obx(
                    () =>  Checkbox(
                        value: controller.privaryPolicy.value,
                        onChanged: (value) => controller.privaryPolicy.value =!controller.privaryPolicy.value,
                    )
            )
        ),
        const SizedBox(width: WNSizes.spaceBtwInputFields,),
        Text.rich(
          TextSpan(
              children:[
                TextSpan(text:WNTexts.iAgreeTo,style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: WNTexts.privacyPolicy,style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? WNColors.textWhite : WNColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? WNColors.textWhite : WNColors.primary,
                )),
                TextSpan(
                    text: WNTexts.and,style: Theme.of(context).textTheme.bodySmall
                ),
                TextSpan(text: WNTexts.termsofuse,style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? WNColors.textWhite : WNColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? WNColors.textWhite : WNColors.primary
                ),),
              ]),
        ),
      ],
    );
  }
}
