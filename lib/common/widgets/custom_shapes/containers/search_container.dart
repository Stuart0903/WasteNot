import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/device/device_utility.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNSearchContainer extends StatelessWidget {
  const WNSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.onTap,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: WNSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: padding,
        child: Container(
          width: WNDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(WNSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                  ? WNColors.dark
                  : WNColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: WNColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: dark ? WNColors.darkerGrey : Colors.grey),
              const SizedBox(width: WNSizes.spaceBtwItems,),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          )
        ),
      ),


    );
  }
}
