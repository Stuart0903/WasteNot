import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/icons/cart_menu_icon.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/utils/constants/text_strings.dart';

class WNHomeAppBar extends StatelessWidget {
  const WNHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return WNAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(WNTexts.homeAppBarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey),),
        Obx(()=> Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),)),
      ],
    ),
      action: [
        WNCartCounterIcon(onPressed: () {}, iconColor: Colors.white,)

      ],
    );
  }
}