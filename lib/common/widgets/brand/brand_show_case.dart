
import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

import 'brand_card.dart';

class WNBrandShowCase extends StatelessWidget {
  const WNBrandShowCase({
    super.key, required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return WNRoundedContainer(
      showBorder: true,
      margin: const EdgeInsets.only(bottom: WNSizes.spaceBtwItems),
      borderColor: WNColors.darkGrey,
      padding: const EdgeInsets.all(WNSizes.md),
      backgroundColor: Colors.transparent,
      child: Column(
          children: [
            ///Brand with Products Count
            const WNBrandCard(showBorder: false),
            ///Brand Top 3 Products Images
            Row(children: images.map((image)=> brandTopProductImageWidget(image, context)).toList())
          ]
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context){
    return Expanded(
      child: WNRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(WNSizes.md),
        margin: const EdgeInsets.only(right: WNSizes.md),
        backgroundColor: WNHelperFunctions.isDarkMode(context)? WNColors.darkerGrey : WNColors.light,
        child: Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}