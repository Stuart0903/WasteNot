import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:wastenot/common/widgets/icons/titlewithVerificationIcon.dart';
import 'package:wastenot/common/widgets/images/circular_image.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/enum.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNBrandCard extends StatelessWidget {
  const WNBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    final isDark = WNHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: WNRoundedContainer(
        padding: const EdgeInsets.all(WNSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// ICon
            Flexible(
              child: WNCircularImage(
                isNetworkImage: false,
                image: WNImages.googleIcon,
                backgroundColor: Colors.transparent,
                overlayColor: isDark? WNColors.white : WNColors.black,
              ),
            ),
            const SizedBox(width: WNSizes.spaceBtwItems/2,),

            ///Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WNBrandTitleWithVerificationIcon(
                      title: 'Nike',
                      brandTextSize: TextSizes.large
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}