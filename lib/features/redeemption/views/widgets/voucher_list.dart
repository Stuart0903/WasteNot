import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/redeemption/views/widgets/voucher_card.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

import '../../controller/redeemption_controller.dart';

class VouchersList extends StatelessWidget {
  final bool dark;

  const VouchersList({super.key, required this.dark});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VoucherController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final vouchers = controller.filteredVouchers;

      if (vouchers.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.ticket,
                size: 64,
                color: dark ? Colors.grey[700] : Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No vouchers available in this category',
                style: TextStyle(
                  fontSize: 16,
                  color: dark ? Colors.grey[400] : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vouchers.length,
          itemBuilder: (context, index) {
            final voucher = vouchers[index];
            return VoucherCard(voucher: voucher, dark: dark);
          },
        ),
      );
    });
  }
}