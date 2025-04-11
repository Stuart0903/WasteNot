import 'package:flutter/material.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/qr_scanner_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class GalleryButton extends StatelessWidget {
  const GalleryButton({
    super.key,
    required this.onPressed,
    this.label = 'Choose from Gallery',
    this.backgroundColor = Colors.blue,
    this.padding = WNSizes.md,
    this.borderRadius = WNSizes.cardRadiusMd,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final double padding;
  final double borderRadius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(padding),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon:  Icon(icon, color: Colors.white),
        label:  Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding:  EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}