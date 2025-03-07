import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class ScanInstructionCard extends StatelessWidget {
  const ScanInstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(WNSizes.md),
      margin: const EdgeInsets.all(WNSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(WNSizes.md),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.qr_code_scanner,
            size: 40,
            color: WNColors.primary,
          ),
          const SizedBox(height: WNSizes.sm),
          Text(
            'Scan a QR code on your recycling bin',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: WNColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: WNSizes.xs),
          Text(
            'Position the QR code within the frame to scan',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}