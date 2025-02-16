
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/onboarding/controllers/onboarding_controller.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class OnBoardingCircBtn extends StatelessWidget {
  const OnBoardingCircBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Positioned(
        right: WNSizes.defaultSpace,
        bottom: kBottomNavigationBarHeight,
        child: ElevatedButton(
            onPressed: ()=> OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: dark? Colors.white70: Colors.black),
            child: Icon(Iconsax.arrow_right_3, color: dark? Colors.black: Colors.white))
    );
  }
}