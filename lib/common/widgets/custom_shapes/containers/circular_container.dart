import 'package:flutter/material.dart';

class WNCircularContainer extends StatelessWidget {
  const WNCircularContainer({
    super.key,
    this.width,
    this.height,
    required this.radius,
    required this.padding,
    this.child,
    required this.backgroundColor,
  });
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
    );
  }
}