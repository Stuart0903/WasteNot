import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/enhanced_item_widget.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/deposit_controller.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class RecyclePiechart extends StatelessWidget {
  const RecyclePiechart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DepositController depositController = Get.put(DepositController());

    return Obx(() {
      final quantities = depositController.itemQuantities.value;

      final plasticCount = quantities["plastic"] ?? 0;
      final canCount = quantities["can"] ?? 0;
      final glassCount = quantities["glass"] ?? 0;
      final totalCount = plasticCount + canCount + glassCount;

      // Calculate percentages safely (avoid division by zero)
      final plasticPercentage = totalCount > 0 ? ((plasticCount / totalCount) * 100).round() : 0;
      final canPercentage = totalCount > 0 ? ((canCount / totalCount) * 100).round() : 0;
      final glassPercentage = totalCount > 0 ? ((glassCount / totalCount) * 100).round() : 0;

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor.withOpacity(0.9),
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
                      'Recycling by Material',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.pie_chart_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: Row(
                    children: [
                      Expanded(
                        child: totalCount > 0
                            ? PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            centerSpaceColor: Colors.transparent,
                            sections: [
                              PieChartSectionData(
                                value: plasticCount.toDouble(),
                                title: '$plasticPercentage%',
                                color: Colors.blue.shade400,
                                radius: 60,
                                titleStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                titlePositionPercentageOffset: 0.55,
                              ),
                              PieChartSectionData(
                                value: canCount.toDouble(),
                                title: '$canPercentage%',
                                color: Colors.teal.shade300,
                                radius: 60,
                                titleStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                titlePositionPercentageOffset: 0.55,
                              ),
                            ],
                          ),
                        )
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.eco_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "No recycling data yet",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EnhancedLegendItem(
                            label: 'Plastic',
                            color: Colors.blue.shade400,
                            fontSize: WNSizes.md,
                          ),
                          const SizedBox(height: 16),
                          EnhancedLegendItem(
                            label: 'Can',
                            color: Colors.teal.shade300,
                            fontSize: WNSizes.md,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                totalCount > 0
                    ? Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Total Items: $totalCount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }
}