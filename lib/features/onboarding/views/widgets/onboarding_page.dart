
import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.heading, required this.subheading,
  });

  final String image, heading, subheading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WNSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: WNHelperFunctions.screenWidth() * 0.8,
            height: WNHelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          Text(
            heading,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            subheading,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}