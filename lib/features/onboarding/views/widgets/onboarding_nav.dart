
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wastenot/features/onboarding/controllers/onboarding_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/helpers/helpers.dart';
class OnBoardingNav extends StatelessWidget {
  const OnBoardingNav({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = WNHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: 145,
        left: 160,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(activeDotColor: dark? WNColors.light: WNColors.dark, dotHeight: 6),
        ),
    );
  }
}