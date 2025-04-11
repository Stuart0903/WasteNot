import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/nav_menu/shop/controllers/redeemption_controller.dart';
import 'package:wastenot/features/personalization/views/settings/widgets/userVoucherdetail.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RedeemptionController controller = Get.put(RedeemptionController());

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
                      'My Rewards',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
                    ),
                    showBackArrow: true,
                  ),

                  const SizedBox(height: WNSizes.spaceBtwSections),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(WNSizes.defaultSpace),
              child: Column(
                children: [
                  // Available Vouchers
                  const WNSectionHeading(title: 'Available Vouchers', showActionButton: false),
                  const SizedBox(height: WNSizes.spaceBtwItems),

                  // Available Vouchers List
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.userVouchers.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(WNSizes.lg),
                          child: Text('No vouchers available'),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.userVouchers.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final voucher = controller.userVouchers[index];
                        final bool isActive = voucher.status== 'reserved';
                        // final String category = voucher['category'] ?? 'other';

                        // // Assign icon based on category
                        // IconData voucherIcon;
                        // switch (category) {
                        //   case 'entertainment':
                        //     voucherIcon = Iconsax.ticket;
                        //     break;
                        //   case 'travel':
                        //     voucherIcon = Iconsax.airplane;
                        //     break;
                        //   case 'service':
                        //     voucherIcon = Iconsax.gift;
                        //     break;
                        //   default:
                        //     voucherIcon = Iconsax.discount_shape;
                        // }

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: WNSizes.sm),
                          child: ListTile(
                            // leading: Icon(
                            //   voucherIcon,
                            //   color: isActive ? Theme.of(context).primaryColor : Colors.grey,
                            //   size: 28,
                            // ),
                            title: Text(
                              voucher.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(voucher.description),
                                const SizedBox(height: WNSizes.xs),
                                Text(
                                  voucher.partnerId,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Valid until: ${voucher.validUntil}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: isActive ? () {
                                // Navigate to voucher details page
                                Get.to(() => VoucherDetailView(voucher: voucher));
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isActive ? Theme.of(context).primaryColor : Colors.grey,
                              ),
                              child: const Text('Use Me'),
                            ),
                            isThreeLine: true,
                            contentPadding: const EdgeInsets.all(WNSizes.md),
                          ),
                        );
                      },
                    );
                  }),

                  const SizedBox(height: WNSizes.spaceBtwSections),

                  // Reward History
                  const WNSectionHeading(title: 'Reward History', showActionButton: false),
                  const SizedBox(height: WNSizes.spaceBtwItems),

                  // History List - You mentioned to ignore this part for now
                  // Placeholder for reward history
                  const Center(child: Text('Reward history will be shown here')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}