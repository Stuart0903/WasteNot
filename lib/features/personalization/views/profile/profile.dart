import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/images/circular_image.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/change_name.dart';
import 'package:wastenot/features/personalization/views/profile/widgets/profile_menu.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const WNAppBar(showBackArrow: true,title: Text('Profile')),


      ///body
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(WNSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const WNCircularImage(image: WNImages.googleIcon, width: 80, height: 80,),
                    TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
                  ]
                ),
              ),


              ///Details
              const SizedBox(height: WNSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwItems,),

              ///Profile Information
              const WNSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: WNSizes.spaceBtwItems),

              WNProfileMenu(title: 'Name',value: controller.user.value.fullName, icon: Iconsax.arrow_right_34, onPressed: ()=> Get.to(()=> const ChangeNameView()),),
              WNProfileMenu(title: 'Username',value: controller.user.value.userName, icon: Iconsax.arrow_right_34, onPressed: (){},),

              const SizedBox(height: WNSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwItems,),

              ///Personal Information
              const WNSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: WNSizes.spaceBtwItems),

              WNProfileMenu(title: 'Phone Number',value: controller.user.value.phoneNumber, icon: Iconsax.arrow_right_34, onPressed: (){},),
              WNProfileMenu(title: 'Email',value: controller.user.value.email, icon: Iconsax.arrow_right_34, onPressed: (){},),
              WNProfileMenu(title: 'Gender',value: controller.user.value.gender, icon: Iconsax.arrow_right_34, onPressed: (){},),

              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwSections,),

              Center(
                child: TextButton(
                    onPressed: ()=>controller.deleteAccountWarningPopup() ,
                    child: const Text('Close Account', style: TextStyle(color: Colors.red))
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}


