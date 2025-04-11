import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:wastenot/features/nav_menu/shop/controllers/redeemption_controller.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class VoucherDetailView extends StatelessWidget {
  final VoucherInfoModel voucher;

  const VoucherDetailView({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RedeemptionController controller = Get.find<RedeemptionController>();

    // Generate data for QR code (using partner_id)
    final String qrData = voucher.id ?? 'invalid-voucher';

    // Format dates for better readability
    final String validFrom = voucher.validFrom ?? 'N/A';
    final String validUntil = voucher.validUntil ?? 'N/A';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            WNPrimaryHeaderContainer(
              child: Column(
                children: [
                  // App Bar
                  WNAppBar(
                    title: Text(
                      'Voucher Details',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
                    ),
                    showBackArrow: true,
                  ),
                  const SizedBox(height: WNSizes.spaceBtwItems),
                ],
              ),
            ),

            // Voucher Details
            Padding(
              padding: const EdgeInsets.all(WNSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Voucher Name
                  Text(
                    voucher.name ?? 'Voucher',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: WNSizes.spaceBtwItems),

                  // QR Code
                  Container(
                    padding: const EdgeInsets.all(WNSizes.lg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: WNSizes.spaceBtwSections),

                  // Voucher ID
                  Text(
                    'Voucher ID: ${voucher.partnerId ?? 'N/A'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: WNSizes.spaceBtwItems),

                  // Voucher Details Card
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(WNSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Description
                          detailRow(
                            context,
                            Iconsax.document_text,
                            'Description',
                            voucher.description ?? 'No description available',
                          ),
                          const Divider(),

                          // Usage Rules
                          detailRow(
                            context,
                            Iconsax.ruler,
                            'Usage Rules',
                            voucher.usageRules ?? 'Standard terms apply',
                          ),
                          const Divider(),

                          // Validity Period
                          detailRow(
                            context,
                            Iconsax.calendar,
                            'Valid Period',
                            'From $validFrom to $validUntil',
                          ),
                          const Divider(),

                          // Category
                          detailRow(
                            context,
                            Iconsax.category,
                            'Category',
                            (voucher.category ?? 'General').toString().capitalize!,
                          ),
                          const Divider(),

                          // Points
                          detailRow(
                            context,
                            Iconsax.medal_star,
                            'Points Required',
                            '${voucher.pointsRequired ?? 'N/A'} points',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: WNSizes.spaceBtwSections),

                  // Redeem Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          // Show confirmation dialog
                          final bool? confirm = await Get.dialog<bool>(
                            AlertDialog(
                              title: const Text('Confirm Redemption'),
                              content: const Text('Are you sure you want to redeem this voucher? This action cannot be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            // Save redemption data and update voucher status
                            await controller.saveRedeemptionData(
                              voucherId: voucher.partnerId ?? '',
                              expiredAt: voucher.validUntil ?? '',
                            );

                            await controller.updateVoucherStatus(voucher.partnerId ?? '');

                            // Show success message and go back
                            Get.snackbar(
                              'Success',
                              'Voucher has been redeemed successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            // Refresh vouchers and go back
                            await controller.getUserVoucherData();
                            Get.back();
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            e.toString(),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: WNSizes.md),
                      ),
                      icon: const Icon(Iconsax.tick_circle),
                      label: const Text('Redeem Now'),
                    ),
                  ),

                  const SizedBox(height: WNSizes.md),

                  // Instructions
                  Container(
                    padding: const EdgeInsets.all(WNSizes.md),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
                    ),
                    child: Column(
                      children: [
                        const Icon(Iconsax.info_circle, color: Colors.blue),
                        const SizedBox(height: WNSizes.xs),
                        Text(
                          'Show this QR code to the partner to redeem your voucher',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create detail rows
  Widget detailRow(BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WNSizes.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: WNSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}