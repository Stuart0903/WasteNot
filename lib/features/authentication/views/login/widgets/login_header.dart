
import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNLoginHeader extends StatelessWidget {
  const WNLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image(height: 100, image: AssetImage(dark? WNImages.darkAppLogo : WNImages.lightAppLogo))),
        const SizedBox(height: WNSizes.md),
        Text(WNTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: WNSizes.sm,),
        Text(WNTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}