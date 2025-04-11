import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/stat_item_widget.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/deposit_controller.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class BottleRecyclingStat extends StatelessWidget {
  const BottleRecyclingStat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DepositController depositController = Get.put(DepositController());

    return Obx(() {
      final quantities = depositController.itemQuantities.value;

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recycling Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.recycling,
                        color: Theme.of(context).colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItemWidget(
                      icon: Icons.local_drink,
                      color: Colors.blue.shade400,
                      count: quantities["plastic"]?.toString() ?? "0",
                      label: 'Plastic',
                    ),
                    Container(
                      height: 60,
                      width: 1,
                      color: Theme.of(context).dividerColor.withOpacity(0.3),
                    ),
                    StatItemWidget(
                      icon: Icons.wine_bar,
                      color: Colors.teal.shade300,
                      count: quantities["can"]?.toString() ?? "0",
                      label: 'Can',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}