import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class WNProfileMenu extends StatelessWidget {
  const WNProfileMenu({
    super.key,
    required this.icon,
    this.onPressed,
    required this.title,
    required this.value,
    this.rightIcon,
  });
  final IconData? icon, rightIcon;
  final VoidCallback? onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: WNSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            /// Icon
            Icon(icon, size: 18), // Add an icon in front
            const SizedBox(width: WNSizes.spaceBtwItems),

            Expanded(flex: 3, child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,)),
            Expanded(flex: 5, child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,)),
            Expanded(child: Icon(rightIcon, size: 18)),
          ],
        ),
      ),
    );
  }
}