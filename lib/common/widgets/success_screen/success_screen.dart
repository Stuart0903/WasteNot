//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/constants/sizes.dart';
//
//
// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});
//   final String image, title, subTitle;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//          child: Padding(
//            padding: WNSpacingStyles.paddingWithAppBarHeight *2,
//            child: Column(
//              children: [
//                ///Image
//                Image(image: AssetImage(image), width: WNHelperFunctions.screenWidth() * 0.6),
//                const SizedBox(height: WNSizes.spaceBtwSections,),
//
//                ///Title and Subtitile
//                Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
//                const SizedBox(height: WNSizes.spaceBtwItems,),
//                Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
//                const SizedBox(height: WNSizes.spaceBtwSections),
//
//                ///Buttons
//                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(()=> const LoginView()), child: const Text("Continue")),),
//
//
//
//
//              ],
//            ),
//          ),
//
//       ),
//     );
//   }
// }
//
