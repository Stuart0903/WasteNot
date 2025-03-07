import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNRoundedImage extends StatelessWidget {
  const WNRoundedImage({
    super.key,
    this.width = 150,
    this.height = 158,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor = WNColors.light,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.fit = BoxFit.contain,
    this.borderRadius = WNSizes.md

  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(WNSizes.md), color: backgroundColor),
          child: ClipRRect(
              borderRadius:applyImageRadius? BorderRadius.circular(WNSizes.md) : BorderRadius.zero,
              child: Image(fit: fit, image: isNetworkImage? NetworkImage(imageUrl): AssetImage(imageUrl) as ImageProvider,)
          )
      ),
    );
  }
}