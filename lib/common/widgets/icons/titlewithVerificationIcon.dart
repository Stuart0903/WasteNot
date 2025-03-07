import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/texts/brand_title_text.dart';
import 'package:wastenot/utils/constants/colors.dart';

import 'package:wastenot/utils/constants/enum.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNBrandTitleWithVerificationIcon extends StatelessWidget {
  const WNBrandTitleWithVerificationIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = WNColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: WNBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: WNSizes.xs),
        const Icon(Iconsax.verify5, color: WNColors.primary, size: WNSizes.iconXs)
      ],
    );
  }
}