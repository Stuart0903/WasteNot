import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNGridLayout extends StatelessWidget {
  const WNGridLayout({super.key,
    required this.itemCount,
    this.mainAxisEvent = 288,
    required this.itemBuilder});
  final int itemCount;
  final double? mainAxisEvent;
  final Widget? Function(BuildContext, int) itemBuilder;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        mainAxisExtent: mainAxisEvent,
        mainAxisSpacing: WNSizes.gridViewSpacing,
        crossAxisSpacing: WNSizes.gridViewSpacing
      ),
      itemBuilder: itemBuilder,
    );
  }
}
