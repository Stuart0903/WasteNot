import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WNCartCounterIcon extends StatelessWidget {
  const WNCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(CupertinoIcons.qrcode), color: iconColor),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white, fontSizeFactor: 0.8),),
            ),
          ),
        )
      ],
    );
  }
}