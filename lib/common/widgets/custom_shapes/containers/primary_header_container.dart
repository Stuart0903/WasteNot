import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:wastenot/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:wastenot/utils/constants/colors.dart';

class WNPrimaryHeaderContainer extends StatelessWidget {
  const   WNPrimaryHeaderContainer({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WNCurvedEdgesWidget(
      child: SizedBox(
        height: 230,
        child: Container(
          color: WNColors.primary,
      
          child: Stack(
            children: [
              Positioned(top: -150, right: -250,child: WNCircularContainer(width: 400, height: 400, radius: 400, padding: 0,backgroundColor: WNColors.textWhite.withOpacity(0.2),)),
              Positioned(top: 100, right: -300,child: WNCircularContainer(width: 400, height: 400, radius: 400, padding: 0,backgroundColor: WNColors.textWhite.withOpacity(0.2),)),
              child,
            ],
          )
        ),
      ),
    );
  }
}