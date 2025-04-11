// File: widgets/enhanced_legend_item.dart

import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/colors.dart';

class EnhancedLegendItem extends StatelessWidget {
  final String? label;
  final Color? color;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? spacing;

  const EnhancedLegendItem({
    Key? key,
    required this.label,
    required this.color,
    this.iconSize = 16,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.spacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: WNColors.primary.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        SizedBox(width: spacing),
        Text(
          label!,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}