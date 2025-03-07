import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:wastenot/common/widgets/images/WN_rounded_image.dart';
import 'package:wastenot/features/Redeem/controllers/home_controllers.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNPromoSlider extends StatelessWidget {
  const WNPromoSlider({
    super.key, required this.banner,
  });

  final List<String> banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
        children:[
          CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                onPageChanged: (index, _) => controller.updatePageIndicator(index)
              ),
              items: banner.map((url)=> WNRoundedImage(imageUrl: url)).toList()
          ),
          const SizedBox(height: WNSizes.spaceBtwItems),
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banner.length; i++)
                  WNCircularContainer(
                      width: 20,
                      height: 4,
                      radius: 400,
                      padding: 0,
                      // margin: EdgeInsets.only(right: 60),
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor: controller.carousalCurrentIndex.value == i ? WNColors.primary : Colors.grey),
            
            
              ],
            ),
          )
        ]
    );
  }
}