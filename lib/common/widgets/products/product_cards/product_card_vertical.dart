import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/styles/shadows.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:wastenot/common/widgets/icons/titlewithVerificationIcon.dart';
import 'package:wastenot/common/widgets/icons/wn_circularIcon.dart';
import 'package:wastenot/common/widgets/images/WN_rounded_image.dart';
import 'package:wastenot/common/widgets/texts/product_price_text.dart';
import 'package:wastenot/common/widgets/texts/product_title_text.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNProductCardVertical extends StatelessWidget {
  const WNProductCardVertical({super.key});



  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [WNNShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(WNSizes.productImageRadius),
          color:  dark ? Colors.black38 : Colors.white,
        ),
        child: Column(
          children: [
            WNRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(WNSizes.sm),
              backgroundColor: dark ? WNColors.dark : WNColors.light,
              child: Stack(
                children: [
                  //Thumnail Image
                  WNRoundedImage(imageUrl: WNImages.googleIcon, applyImageRadius: true,),
      
                  /// Sale Tag
                  WNRoundedContainer(
                    radius: WNSizes.sm,
                    backgroundColor: WNColors.textSecondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: WNSizes.sm, vertical: WNSizes.xs),
                    child: Text( '25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: WNColors.black),),
                  ),
      
                  /// Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                      child: WNCircularIcon(icon: Iconsax.heart5,color: Colors.red)
                  )
      
                ],
              ),
      
            ),
      
            const SizedBox(height: WNSizes.spaceBtwItems,),
      
            ///Details
            Padding(
                padding: EdgeInsets.only(left: WNSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WNProductTitleText(title: "Red shoe", smallSize: true,),
                  const SizedBox(height: WNSizes.spaceBtwItems/2,),
                ],
              ),
            ),

            const Spacer(),

            ///Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Price
                const Padding(
                  padding: EdgeInsets.only(left: WNSizes.sm),
                    child: const WNProductPriceText(price: '35.0', isLarge: true,)),

                ///Add to cart
                Container(
                  decoration: const BoxDecoration(
                      color: WNColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(WNSizes.cardRadiusMd),
                        bottomLeft: Radius.circular(WNSizes.productImageRadius),
                      )
                  ),
                  child: const SizedBox(
                      width: WNSizes.iconLg * 1.2,
                      height: WNSizes.iconLg * 1.2,
                      child: Center(child: Icon(Iconsax.add, color: Colors.white))),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}




