import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/device/device_utility.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WNHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background colors
            Column(
              children: [
                Container(
                  height: WNDeviceUtils.getScreenHeight()/2.5, // Adjust the height as needed
                  color: Colors.green,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(WNSizes.defaultSpace),
                          child: WNSectionHeading(title: 'Transactions', showActionButton: true)
                      ),
                      Container(
                        height: 80,
                        width: WNDeviceUtils.getScreenWidth(context),
                        color: Colors.red,
                      )

                    ],

                  )
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.zero,
              child: Column(
                children: [
                  WNAppBar(title: Text('Greetings Users!!!', style: Theme.of(context).textTheme.headlineMedium,),action: [IconButton(onPressed: (){}, icon: Icon(Iconsax.notification))],),
                  const SizedBox(height: WNSizes.spaceBtwItems,),
                  WNSearchContainer(text: 'Search Here', showBorder: false),
                  const SizedBox(height: WNSizes.spaceBtwItems,),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Available Points',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: WNSizes.defaultSpace/2,),
                        Text('20000', style: Theme.of(context).textTheme.headlineMedium,)
                      ],
                    ),
                  )
                ],
              ),
            ),


            // Your other widgets go here
          ],
        ),
      ),
    );
  }
}
