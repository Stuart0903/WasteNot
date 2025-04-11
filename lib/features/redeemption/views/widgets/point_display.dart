import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/userPoint_controller.dart';
import 'package:wastenot/features/redeemption/controller/redeemption_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class PointsDisplay extends StatelessWidget {

  const PointsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    final controller = Get.put(UserPointController());

    return Obx(() => Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: dark
            ? Colors.amber.shade900.withOpacity(0.2)
            : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WNColors.primary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.coin,
            color: WNColors.primary,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            '${controller.userPoints.value?.availablePoints ?? 0}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WNColors.primary,
            ),
          ),
        ],
      ),
    ));
  }
}