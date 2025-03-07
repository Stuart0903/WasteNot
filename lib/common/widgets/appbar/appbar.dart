import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/device/device_utility.dart';

class WNAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WNAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBackArrow = false,
    this.leadingIcon,
    this.action,
    this.leadingOnPressed,
  });

  final Widget? title;
  final Widget? subtitle;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? action;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: WNSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        )
            : leadingIcon != null
            ? IconButton(
          onPressed: leadingOnPressed,
          icon: Icon(leadingIcon),
        )
            : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) title!,
            if (subtitle != null) subtitle!,
          ],
        ),
        actions: action,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(WNDeviceUtils.getAppBarHeight());
}
