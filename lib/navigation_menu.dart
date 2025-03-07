
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart%20';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/Redeem/views/home/home.dart';
import 'package:wastenot/features/brands/brands.dart';
import 'package:wastenot/features/nav_menu/home/views/home_views.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/qr_scanner_view.dart';
import 'package:wastenot/features/personalization/views/settings/settings.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});


  @override
  Widget build(BuildContext context) {
    final darkMode = WNHelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
          () => NavigationBar(
          height: 80,
          elevation: 2,
          selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index)=> controller.selectedIndex.value = index,
            backgroundColor: darkMode? Colors.black: Colors.white,
            indicatorColor: darkMode? Colors.white.withOpacity(0.1): Colors.black.withOpacity(0.1),
            destinations: [
              NavigationDestination(icon: Icon(CupertinoIcons.home), label: 'Home'),
              NavigationDestination(icon: Icon(CupertinoIcons.shopping_cart), label: 'Shop'),
              NavigationDestination(icon: Icon(CupertinoIcons.qrcode), label: 'Scan'),
              NavigationDestination(icon: Icon(CupertinoIcons.person), label: 'Profile'),
        
            ]
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value],)
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeView(),
    HomePageView(),
    const QRScannerPage(),
    const SettingsView(),
  ];
}




