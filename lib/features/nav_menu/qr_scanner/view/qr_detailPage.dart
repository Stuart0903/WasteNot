// File: lib/features/nav_menu/qr_scanner/view/qr_detail_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/widgets/recycling_item_card.dart';
import 'package:wastenot/navigation_menu.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import '../controller/qr_scanner_controller.dart';
import '../model/qr_scanner_model.dart';


class QRDetailPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> scannedData;

  const QRDetailPage({
    Key? key,
    required this.scannedData,
  }) : super(key: key);

  int calculateTotalPoints() {
    int total = 0;
    for (var entry in scannedData.entries) {
      total += (entry.value['count'] as int) * RecyclingData.getPointsPerItem(entry.key);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final QRScannerController controller = Get.find<QRScannerController>();
    final totalPoints = calculateTotalPoints();
    final totalItems = scannedData.values.fold(0, (sum, item) => sum + (item['count'] as int));

    return Scaffold(
      appBar: WNAppBar(
        title: const Text('Recycling Details'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(context, totalItems),

            const SizedBox(height: WNSizes.spaceBtwSections),

            // Materials list
            Text(
              'Materials',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: WNSizes.sm),

            // List of recycling items
            Expanded(
              child: ListView.builder(
                itemCount: scannedData.length,
                itemBuilder: (context, index) {
                  final entry = scannedData.entries.elementAt(index);
                  final materialType = entry.key;
                  final count = entry.value['count'] as int;

                  return RecyclingItemCard(
                    materialType: materialType,
                    count: count,
                  );
                },
              ),
            ),

            // Points summary and claim button
            _buildBottomSection(context, controller, totalPoints),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, int totalItems) {
    return Container(
      padding: const EdgeInsets.all(WNSizes.md),
      decoration: BoxDecoration(
        color: WNColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(WNSizes.md),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.recycling,
            size: 36,
            color: WNColors.primary,
          ),
          const SizedBox(width: WNSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recycling Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: WNColors.primary,
                  ),
                ),
                Text(
                  '$totalItems ${totalItems == 1 ? 'item' : 'items'} found',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, QRScannerController controller, int totalPoints) {
    return Container(
      padding: const EdgeInsets.all(WNSizes.md),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(WNSizes.md),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Points:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$totalPoints pts',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: WNColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: WNSizes.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Show success notification
                Get.snackbar(
                  'Claim Successful',
                  'You have claimed $totalPoints points!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.all(WNSizes.md),
                  borderRadius: WNSizes.md,
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                );

                // Wait for snackbar to be visible before navigating
                Future.delayed(const Duration(seconds: 1), () {
                  controller.resetScan();

                  // Navigate to home and ensure Home tab is selected
                  Get.offAll(() => const NavigationMenu());
                  Get.find<NavigationController>().selectedIndex.value = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: WNColors.primary,
                padding: const EdgeInsets.symmetric(vertical: WNSizes.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(WNSizes.md),
                ),
              ),
              child: Text(
                'CLAIM POINTS',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: WNSizes.sm),
          TextButton(
            onPressed: () {
              controller.resetScan();
              Get.back();
            },
            child: const Text('Scan New QR'),
          ),
        ],
      ),
    );
  }
}