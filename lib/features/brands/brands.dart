// import 'package:flutter/material.dart';
// import 'package:wastenot/common/widgets/appbar/appbar.dart';
// import 'package:wastenot/common/widgets/appbar/tabbar.dart
// import 'package:wastenot/common/widgets/brand/brand_show_case.dart';';
// import 'package:wastenot/common/widgets/custom_shapes/containers/rounded_container.dart';
// import 'package:wastenot/common/widgets/custom_shapes/containers/search_container.dart';
// import 'package:wastenot/common/widgets/icons/cart_menu_icon.dart';
// import 'package:wastenot/common/widgets/icons/titlewithVerificationIcon.dart';
// import 'package:wastenot/common/widgets/images/circular_image.dart';
// import 'package:wastenot/common/widgets/layouts/grid_layout.dart';
// import 'package:wastenot/common/widgets/brand/brand_card.dart';
// import 'package:wastenot/common/widgets/texts/section_heading.dart';
// import 'package:wastenot/utils/constants/colors.dart';
// import 'package:wastenot/utils/constants/enum.dart';
// import 'package:wastenot/utils/constants/image_strings.dart';
// import 'package:wastenot/utils/constants/sizes.dart';
// import 'package:wastenot/utils/helpers/helpers.dart';
//
// class BrandsView extends StatelessWidget {
//   const BrandsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = WNHelperFunctions.isDarkMode(context);
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: WNAppBar(
//           title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,),
//           action: [
//             WNCartCounterIcon(onPressed: (){}, iconColor: Colors.blue)
//           ],
//         ),
//         body: NestedScrollView(
//             headerSliverBuilder: (_, innerBoxIsScrolled){
//                return[
//                  SliverAppBar(
//                    automaticallyImplyLeading: false,
//                    pinned: true,
//                    floating: true,
//                    backgroundColor: WNHelperFunctions.isDarkMode(context) ? Colors.black : Colors.white,
//                    expandedHeight: 440,
//
//                    flexibleSpace: Padding(
//                        padding: EdgeInsets.all(WNSizes.defaultSpace),
//                      child: ListView(
//                        shrinkWrap: true,
//                        physics: const NeverScrollableScrollPhysics(),
//                        children: [
//                          //Search Bar
//                          SizedBox(height: WNSizes.spaceBtwItems,),
//                          WNSearchContainer(text: 'Search in Store',showBackground: false, padding: EdgeInsets.zero,),
//
//                          SizedBox(height: WNSizes.spaceBtwSections,),
//
//                          /// Featured Brands
//                          WNSectionHeading(
//                              title: 'Featured Brands',
//                            onPressed: (){},
//                          ),
//                          const SizedBox(height: WNSizes.spaceBtwItems / 1.5,),
//
//                          WNGridLayout(itemCount: 4, mainAxisEvent: 80, itemBuilder: (_, index){
//                            return WNBrandCard(showBorder: false,);
//                          })
//
//                        ],
//                      ),
//                    ),
//                    ///Tabs
//                    bottom: WNTabBar(
//                        tabs: [
//                          Tab(text: 'All',),
//                          Tab(text: 'Men',),
//                          Tab(text: 'Women',),
//                          Tab(text: 'Kids',),
//                        ],
//                    )
//                  )
//                ];
//             },
//
//             ///Body
//             body: TabBarView(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.all(WNSizes.defaultSpace),
//                     child: Column(
//                       children: [
//                         ///Brands
//                         WNBrandShowCase(images: [
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                         ],)
//                         ///Products you may like
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(WNSizes.defaultSpace),
//                     child: Column(
//                       children: [
//                         ///Brands
//                         WNBrandShowCase(images: [
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                         ],)
//                         ///Products you may like
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(WNSizes.defaultSpace),
//                     child: Column(
//                       children: [
//                         ///Brands
//                         WNBrandShowCase(images: [
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                         ],)
//                         ///Products you may like
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(WNSizes.defaultSpace),
//                     child: Column(
//                       children: [
//                         ///Brands
//                         WNBrandShowCase(images: [
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                           WNImages.googleIcon,
//                         ],)
//                         ///Products you may like
//                       ],
//                     ),
//                   )
//
//                 ]
//             )
//         )
//       ),
//     );
//   }
// }
//
//
//
//
//
