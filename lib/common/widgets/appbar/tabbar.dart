import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/device/device_utility.dart';

class WNTabBar extends StatelessWidget implements PreferredSizeWidget {
  const WNTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: dark ? WNColors.black : WNColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: WNColors.primary,
        labelColor: dark ? WNColors.white : WNColors.primary,
        unselectedLabelColor: WNColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(WNDeviceUtils.getAppBarHeight());
}
