import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/helpers/helpers.dart';


class WNShimmerEffect extends StatelessWidget {
  const WNShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? WNColors.darkerGrey : WNColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
