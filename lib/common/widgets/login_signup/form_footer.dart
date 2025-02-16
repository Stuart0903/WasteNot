
import 'package:flutter/material.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNLoginFooter extends StatelessWidget {
  const WNLoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: (){},
              icon: const Image(
                  width: WNSizes.iconMd,
                  height: WNSizes.iconMd,
                  image: AssetImage(WNImages.googleIcon)
              )),
        ),
        const SizedBox(width: WNSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: (){},
              icon: const Image(
                  width: WNSizes.iconMd,
                  height: WNSizes.iconMd,
                  image: AssetImage(WNImages.facebookIcon)
              )),
        ),

      ],
    );
  }
}
