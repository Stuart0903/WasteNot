import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/redeemption/controller/redeemption_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class PointCard extends StatelessWidget {
  const PointCard({
    super.key,
    required this.controller,
  });

  final VoucherController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(WNSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Points",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: WNSizes.sm),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: WNColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: WNSizes.defaultSpace*0.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                      ()=> Text(
                    "${controller.currentPoints}",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: WNColors.primary
                    ),
                  ),
                ),
                const SizedBox(width: WNSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'points',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}