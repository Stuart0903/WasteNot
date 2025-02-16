
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNAnimationLoaderWidget extends StatelessWidget {
  const WNAnimationLoaderWidget({super.key, required this.text, required this.animation, this.actionText, this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction = false;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), //Display Lottie Animation
          const SizedBox(height: WNSizes.defaultSpace,),
          showAction?
              SizedBox(
                width: 250,
                child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.black26),
                    child: Text(
                        actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white60),
                    )),
              )
          : const SizedBox(),
        ]
      ),
    );
  }
}

