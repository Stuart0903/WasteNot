import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/deposit_controller.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/userPoint_controller.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/widgets/recycling_item_card.dart';
import 'package:wastenot/navigation_menu.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/popups/loaders.dart';
import '../controller/qr_scanner_controller.dart';
import '../model/qr_scanner_model.dart';

class QRDetailPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> scannedData;
  final String qrId;

  const QRDetailPage({
    Key? key,
    required this.scannedData,
    this.qrId = '',
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
    final QRScannerController controller = Get.put(QRScannerController());
    final totalPoints = calculateTotalPoints();
    final totalItems = scannedData.values.fold(0, (sum, item) => sum + (item['count'] as int));

    return Scaffold(
      appBar: WNAppBar(
        title: const Text('Recycling Details'),
        showBackArrow: true,
        onPressed: () {
          controller.resetScan();
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR ID section removed
            _buildHeaderSection(context, totalItems),
            const SizedBox(height: WNSizes.spaceBtwSections),
            Text(
              'Materials',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: WNSizes.sm),
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
    final userPointController = Get.put(UserPointController());
    final depositController = Get.put(DepositController());

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
              onPressed: () async {
                try {
                  // Show loading indicator
                  Get.dialog(
                    const Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );

                  // Check for duplicate QR
                  final isDuplicate = await controller.isQrDuplicate();
                  Get.back();

                  if (isDuplicate) {
                    Get.snackbar(
                      'Duplicate QR Code',
                      'This QR code has already been claimed',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    await Future.delayed(const Duration(milliseconds: 1500));
                    Get.back();
                  } else {
                    await userPointController.updateUserPoints(totalPoints);
                    await depositController.createDeposit(scannedData, totalPoints.toDouble());
                    await controller.qrdetail();

                    Get.snackbar(
                      'Claim Successful',
                      'You have claimed $totalPoints points!',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                      margin: const EdgeInsets.all(WNSizes.md),
                      borderRadius: WNSizes.md,
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                    );

                    await Future.delayed(const Duration(seconds: 1));
                    controller.resetScan();
                    Get.offAll(() => const NavigationMenu());
                    Get.find<NavigationController>().selectedIndex.value = 0;
                  }
                } catch (e) {
                  if (Get.isDialogOpen!) Get.back();

                  Get.snackbar(
                    'Error',
                    'Failed to claim points: ${e.toString()}',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 3),
                    margin: const EdgeInsets.all(WNSizes.md),
                    borderRadius: WNSizes.md,
                    icon: const Icon(Icons.error, color: Colors.white),
                  );
                }
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
