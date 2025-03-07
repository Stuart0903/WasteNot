import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';

import 'package:wastenot/common/widgets/images/circular_image.dart';
import 'package:wastenot/common/widgets/list_tiles/settings_menu_title.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/profile.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            WNPrimaryHeaderContainer(
                child: Column(
                  children: [
                    ///App Bard
                    WNAppBar(
                      title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
                    ),
                    const SizedBox(height: WNSizes.spaceBtwItems,),

                    ///UserProfileCard
                    ListTile(
                      leading: WNCircularImage(
                        image: WNImages.googleIcon,
                        width: 50,
                        height: 50,
                        padding: 0,
                      ),
                      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white)),
                      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
                      trailing: IconButton(onPressed: ()=> Get.to(()=> const ProfileView()), icon: const Icon(Iconsax.edit, color: Colors.white)),
                    ),
                    const SizedBox(height: WNSizes.spaceBtwSections),


                  ],
                )
            ),
            /// BODY
            Padding(
                padding: const EdgeInsets.all(WNSizes.defaultSpace),
              child: Column(
                children: [
                  ///Account SEttings
                  WNSectionHeading(title: 'Account Settings', showActionButton: false,),
                  SizedBox(height: WNSizes.spaceBtwItems),

                  WNSettingsMenuTile(icon: Iconsax.safe_home, title: 'Address', subtitle: 'Manage your address', onTap: (){},),
                  WNSettingsMenuTile(icon: Iconsax.safe_home, title: 'Address', subtitle: 'Manage your address', onTap: (){},),
                  WNSettingsMenuTile(icon: Iconsax.safe_home, title: 'Address', subtitle: 'Manage your address', onTap: (){},),
                  WNSettingsMenuTile(icon: Iconsax.safe_home, title: 'Address', subtitle: 'Manage your address', onTap: (){},),

                ]
              ),
            )
          ],
        )
      )
    );
  }
}
