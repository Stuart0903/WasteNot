import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wastenot/common/widgets/loaders/shimmer_effect.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNCircularImage extends StatelessWidget {
  const WNCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = WNSizes.sm,
    this.isNetworkImage = false,
    this.borderColor = WNColors.primary, // Border color
    this.borderWidth = 1.0, // Border width
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final Color borderColor; // Border color
  final double borderWidth; // Border width

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // If image background color is null then switch it to light and dark mode color design.
        color: backgroundColor ?? (WNHelperFunctions.isDarkMode(context) ? WNColors.black : WNColors.white),
        borderRadius: BorderRadius.circular(100), // Circular shape
        border: Border.all(
          color: borderColor, // Border color
          width: borderWidth, // Border width
        ),
      ),
      child: ClipOval(
        child: isNetworkImage
            ? _buildNetworkImage() // Handle network image
            : _buildAssetImage(), // Handle local asset image
      ),
    );
  }

  // Build network image with error handling and shimmer effect
  Widget _buildNetworkImage() {
    return Image.network(
      image,
      fit: fit,
      color: overlayColor,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        // Show shimmer effect while loading
        return WNShimmerEffect(
          width: width,
          height: height,
          radius: 100, // Circular shape
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Display a placeholder if the image fails to load
        return Icon(Icons.person, size: width, color: overlayColor);
      },
    );
  }

  // Build local asset image
  Widget _buildAssetImage() {
    return Image(
      fit: fit,
      image: AssetImage(image),
      color: overlayColor,
      errorBuilder: (context, error, stackTrace) {
        // Display a placeholder if the asset image fails to load
        return Icon(Icons.person, size: width, color: overlayColor);
      },
    );
  }
}