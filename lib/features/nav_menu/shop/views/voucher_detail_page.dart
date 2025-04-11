import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/userPoint_controller.dart';
import 'package:wastenot/features/nav_menu/shop/controllers/redeemption_controller.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/popups/loaders.dart';

import '../../../redeemption/model/voucher_info.dart';

class VoucherDetailView extends StatefulWidget {
  final VoucherInfoModel voucherInfo;

  const VoucherDetailView({super.key, required this.voucherInfo});

  @override
  State<VoucherDetailView> createState() => _VoucherDetailViewState();
}

class _VoucherDetailViewState extends State<VoucherDetailView> {
  bool _isRedeemed = false;
  final controller = Get.put(RedeemptionController());
  final usercontroller = Get.put(UserPointController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WNAppBar(
        title: const Text('Voucher details'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///Voucher Image
            AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage(WNImages.facebookIcon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: WNSizes.spaceBtwItems),

            ///Voucher details
            Padding(
              padding: EdgeInsets.all(WNSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WNSectionHeading(title: 'About Voucher', showActionButton: false),
                  SizedBox(height: WNSizes.spaceBtwItems),

                  // Voucher status indicator
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: WNSizes.md,
                        vertical: WNSizes.xs
                    ),
                    decoration: BoxDecoration(
                      color: _isRedeemed ? Colors.grey[200] : Colors.green[50],
                      borderRadius: BorderRadius.circular(WNSizes.sm),
                    ),
                    child: Text(
                      _isRedeemed ? 'Reserved' : widget.voucherInfo.status,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: _isRedeemed ? Colors.grey[700] : Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: WNSizes.spaceBtwItems),

                  // Voucher name
                  Text(
                    widget.voucherInfo.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: WNSizes.spaceBtwItems / 2),

                  // Validity date
                  _buildInfoRow(
                      context,
                      Icons.calendar_today_outlined,
                      'Valid until: ${widget.voucherInfo.validUntil}'
                  ),
                  SizedBox(height: WNSizes.spaceBtwItems / 2),

                  // Location (partner info)
                  _buildInfoRow(
                      context,
                      Icons.location_on_outlined,
                      'Partner ID: ${widget.voucherInfo.partnerId}'
                  ),

                  SizedBox(height: WNSizes.spaceBtwSections),

                  // Redeem Button Section
                  if (!_isRedeemed) _buildRedeemButtonSection(context),

                  SizedBox(height: WNSizes.spaceBtwSections),

                  // Terms and conditions
                  const WNSectionHeading(title: 'Terms & Conditions', showActionButton: false),
                  SizedBox(height: WNSizes.spaceBtwItems / 2),

                  Text(
                    widget.voucherInfo.usageRules,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        SizedBox(width: WNSizes.spaceBtwItems / 2),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildRedeemButtonSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WNSectionHeading(title: 'Redeem Voucher', showActionButton: false),
        SizedBox(height: WNSizes.spaceBtwItems / 2),

        Text(
          'Present this voucher at the partner location to redeem your offer.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        SizedBox(height: WNSizes.spaceBtwItems),

        // Redeem button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showRedemptionConfirmation(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: WNSizes.buttonHeight),
              backgroundColor: WNColors.primary, // Use your app's primary color
            ),
            child: Text(
              'Redeem Now',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showRedemptionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Redemption'),
        content: const Text(
            'Are you sure you want to redeem this voucher? This action cannot be undone.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final userPoints = usercontroller.userPoints.value?.availablePoints?? 0;

              final requiredPoints = widget.voucherInfo.pointsRequired;
              if (userPoints < requiredPoints) {
                WNLoaders.errorSnackBar(
                    title: "Oh Shoot",
                  message: "You don't have enough points to redeem this voucher."
                );
                return; // Stop further execution
              }

              try{
                await controller.saveRedeemptionData(
                    voucherId: widget.voucherInfo.id,
                    expiredAt: widget.voucherInfo.validUntil);
                await controller.updateVoucherStatus(widget.voucherInfo.id);
              }catch(e){
                throw e.toString();
              }
              setState(() {
                _isRedeemed = true;
              });
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voucher redeemed successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: WNColors.primary, // Use your app's primary color
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}