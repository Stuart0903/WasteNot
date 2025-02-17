
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Scaffold(

      backgroundColor: dark ? Colors.black38 : Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade300,
        color: dark ? Colors.black38: Colors.white60,
        items: [
        SvgPicture.asset("assets/images/svgimages/home.svg",
        colorFilter: ColorFilter.mode(
          dark ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
        ),
        SvgPicture.asset("assets/images/svgimages/voucher.svg",
          colorFilter: ColorFilter.mode(
          dark ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
        ),
        SvgPicture.asset("assets/images/svgimages/qr.svg",
          colorFilter: ColorFilter.mode(
            dark ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        SvgPicture.asset("assets/images/svgimages/person.svg",
          colorFilter: ColorFilter.mode(
            dark ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        ],
      ),
    );
  }
}




