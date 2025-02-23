// import 'package:flutter/material.dart';
// import 'package:wastenot/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
//
// class WNCurvedEdgeWidget extends StatelessWidget {
//   const WNCurvedEdgeWidget({
//     super.key, this.child,
//   });
//   final Widget ? child;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: WNCustomCurvedEdges(),
//       child: child,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wastenot/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class WNCurvedEdgesWidget extends StatelessWidget {
  const WNCurvedEdgesWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WNCustomCurvedEdges(),
      child: child,
    );
  }
}
