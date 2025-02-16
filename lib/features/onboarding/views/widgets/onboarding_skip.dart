
import 'package:flutter/material.dart';
import 'package:wastenot/features/onboarding/controllers/onboarding_controller.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: kToolbarHeight,right: WNSizes.defaultSpace,
        child: TextButton(onPressed:(){
          OnBoardingController.instance.skipPage();
        },
            child: const Text('Skip')));
  }
}