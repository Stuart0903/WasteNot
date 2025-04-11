import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/redeemption/controller/redeemption_controller.dart';
import 'package:wastenot/features/redeemption/views/widgets/error_display.dart';
import 'package:wastenot/features/redeemption/views/widgets/point_display.dart';
import 'package:wastenot/features/redeemption/views/widgets/voucher_list.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class RedeemPageScreen extends StatelessWidget {
  const RedeemPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController());
    final dark = WNHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: dark ? Colors.black : Colors.white,
        foregroundColor: dark ? Colors.white : Colors.black87,
        title: Text(
          'Voucher Redemption',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: dark ? Colors.white : Colors.black87,
          ),
        ),
        actions: [
          PointsDisplay(),
        ],
      ),
      body: Obx(() {
        // Show loading if either vouchers or points are loading
        if (controller.isLoading.value || controller.isPointsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show voucher error if exists
        if (controller.error.value.isNotEmpty) {
          return ErrorDisplay(
            icon: Icons.error_outline,
            message: controller.error.value,
            onRetry: () => controller.refreshData(),
            iconColor: Colors.red,
          );
        }

        return Column(
          children: [

            // Vouchers list
            Expanded(
              child: VouchersList(dark: dark),
            ),
          ],
        );
      }),



    );
  }
}
