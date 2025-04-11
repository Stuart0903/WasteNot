// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wastenot/features/redeemption/controller/redeemption_controller.dart';
// import 'package:wastenot/utils/helpers/helpers.dart';
//
// class CategoriesList extends StatelessWidget {
//   final bool dark;
//
//   const CategoriesList({super.key, required this.dark});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<VoucherController>();
//
//     return SizedBox(
//       height: 80,
//       child: Obx(() => ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         itemCount: controller.categories.length,
//         itemBuilder: (context, index) {
//           final category = controller.categories[index];
//           return GestureDetector(
//             onTap: () => controller.selectCategory(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: controller.selectedCategoryIndex.value == index
//                     ? Theme.of(context).primaryColor
//                     : dark
//                     ? Colors.grey[800]
//                     : Colors.grey[200],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     category.icon,
//                     color: controller.selectedCategoryIndex.value == index
//                         ? Colors.white
//                         : dark
//                         ? Colors.white70
//                         : Colors.black54,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     category.name,
//                     style: TextStyle(
//                       color: controller.selectedCategoryIndex.value == index
//                           ? Colors.white
//                           : dark
//                           ? Colors.white70
//                           : Colors.black54,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       )),
//     );
//   }
// }