import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/brand/brand_show_case.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNCategoryTab extends StatelessWidget {
  const WNCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
      child: Column(
        children: [
          ///Brands
          WNBrandShowCase(images: [
            WNImages.googleIcon,
            WNImages.googleIcon,
            WNImages.googleIcon
          ]),

          ///Products
          WNSectionHeading(title: 'You might Like', onPressed: (){},),
          const SizedBox(height: WNSizes.spaceBtwItems,),
          ]
      ),
    );
  }
}
