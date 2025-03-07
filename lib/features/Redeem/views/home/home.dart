import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:wastenot/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:wastenot/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:wastenot/common/widgets/icons/cart_menu_icon.dart';
import 'package:wastenot/common/widgets/images/WN_rounded_image.dart';
import 'package:wastenot/common/widgets/layouts/grid_layout.dart';
import 'package:wastenot/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/Redeem/views/home/widgets/promo_slider.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/device/device_utility.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

import 'widgets/home_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark =WNHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            WNPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///App bar
                  WNHomeAppBar(),
                  const SizedBox(height: WNSizes.spaceBtwSections,),
                  ///Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: WNSizes.defaultSpace),
                    child: Container(
                      width: WNDeviceUtils.getScreenWidth(context),
                      padding: const EdgeInsets.all(WNSizes.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
                        border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.search, color: dark? Colors.white : Colors.black),
                          const SizedBox(width: WNSizes.spaceBtwSections,),
                          Text('Search Here', style: Theme.of(context).textTheme.bodySmall),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: WNSizes.spaceBtwItems,)
                ],

              )
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(WNSizes.defaultSpace),
              child: Column(
                children: [
                  ///Promo Slider
                  WNPromoSlider(banner: [
                    WNImages.onBoardingImage1,
                    WNImages.onBoardingImage2,
                    WNImages.onBoardingImage3
                  ],),
                  const SizedBox(height: WNSizes.spaceBtwSections,),

                  ///Heading
                  const WNSectionHeading(title: 'Popular Products',),

                  const SizedBox(height: WNSizes.spaceBtwItems,),

                  ///Popular Products
                  WNGridLayout(itemCount: 6, itemBuilder: (_, index) => WNProductCardVertical())
                  // WNProductCardVertical()

                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}














