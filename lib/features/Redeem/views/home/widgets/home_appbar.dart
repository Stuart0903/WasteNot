import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/icons/cart_menu_icon.dart';
import 'package:wastenot/utils/constants/text_strings.dart';

class WNHomeAppBar extends StatelessWidget {
  const WNHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WNAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(WNTexts.homeAppBarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey),),
        Text(WNTexts.homeAppBarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),),
      ],
    ),
      action: [
        WNCartCounterIcon(onPressed: () {}, iconColor: Colors.white,)

      ],
    );
  }
}