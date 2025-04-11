import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';
import 'package:wastenot/utils/constants/colors.dart';

import '../../controller/redeemption_controller.dart';

class VoucherCard extends StatelessWidget {
  final VoucherInfoModel voucher;
  final bool dark;

  const VoucherCard({
    super.key,
    required this.voucher,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildFooter(),
            const SizedBox(height: 12),
            _buildRedeemButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: dark ? Colors.grey[700] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              _getIconForCategory(voucher.category),
              color: WNColors.primary,
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                voucher.description,
                style: TextStyle(
                  fontSize: 14,
                  color: dark ? Colors.grey[400] : Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Iconsax.calendar, size: 16),
            const SizedBox(width: 4),
            Text(
              'Valid until ${_formatDate(voucher.validUntil)}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: WNColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Iconsax.coin, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                '${voucher.pointsRequired}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRedeemButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final controller = Get.find<VoucherController>();
          controller.navigateToVoucherDetail(voucher);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: WNColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Redeem'),
      ),
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'N/A';

    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateString;
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Iconsax.cake;
      case 'drinks': return Iconsax.coffee;
      case 'shopping': return Iconsax.shopping_bag;
      case 'entertainment': return Iconsax.game;
      case 'travel': return Iconsax.airplane;
      case 'health': return Iconsax.heart;
      case 'beauty': return Iconsax.brush_1;
      case 'education': return Iconsax.book_1;
      case 'fitness': return Iconsax.weight;
      case 'electronics': return Iconsax.mobile;
      default: return Iconsax.gift;
    }
  }
}