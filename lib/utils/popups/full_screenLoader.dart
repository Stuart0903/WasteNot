
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/loaders/animation_loader.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class WNFullScreenLoader{

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: WNHelperFunctions.isDarkMode(Get.context!) ? Colors.black26 : Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(  // Add this
              child: Column(
                mainAxisSize: MainAxisSize.min,  // ✅ Use min to avoid unnecessary height
                children: [
                  const SizedBox(height: 50),  // Reduce the space
                  WNAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }



}
