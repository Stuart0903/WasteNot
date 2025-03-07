import 'package:flutter/material.dart';

class WNProductPriceText extends StatelessWidget {
  const WNProductPriceText({
    super.key,
    this.currencySign = '\Rs',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign;
  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: isLarge ? 24.0 : 16.0, // Assuming default font sizes
        decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
