
import 'package:flutter/material.dart';
import 'package:wastenot/utils/helpers/helpers.dart';


class WNLoginDivider extends StatelessWidget {
  const WNLoginDivider({super.key, required this.dividerText});

  final String dividerText;
  @override
  Widget build(BuildContext context) {
    final bool dark = WNHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark? Colors.grey : Colors.grey, thickness: 0.5,indent: 60, endIndent: 5  )),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: dark? Colors.grey : Colors.grey, thickness: 0.5,indent: 5, endIndent: 60  ))
      ],

    );
  }
}
