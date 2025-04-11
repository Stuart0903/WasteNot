import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/images/circular_image.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/personalization/controllers/update_details/update_user_details_controllers.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/change_name.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/update_dob_view.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/update_gender_view.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/update_single_field_details.dart';
import 'package:wastenot/features/personalization/views/profile/widgets/profile_menu.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final updatecontroller = Get.put(UpdateUserDetailsControllers());
    return Scaffold(
      appBar: const WNAppBar(
        showBackArrow: true,
        title: Text('View/Edit your profile Information'),
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WNSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Display profile image with edit button
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Circular Image
                        GestureDetector(
                          onTap: () => controller.uploadProfilePicture(),
                          child: Obx(() {
                            final profileImageUrl = controller.user.value.profilePicture;
                            return WNCircularImage(
                              image: profileImageUrl.isNotEmpty
                                  ? profileImageUrl
                                  : 'assets/images/default_profile.png', // Default local asset
                              isNetworkImage: profileImageUrl.isNotEmpty, // Use network image if URL is available
                              width: 110,
                              height: 110,
                            );
                          }),
                        ),
                        // Edit Icon with Background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue, // Semi-transparent background
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                            border: Border.all(
                              color: Colors.white, // White border
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Iconsax.camera, // Use a camera icon for better UX
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: WNSizes.spaceBtwItems),
                    Text(
                      '${controller.user.value.firstName} ${controller.user.value.lastName}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      controller.user.value.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: WNSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwItems),

              /// Profile Information
              const WNSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: WNSizes.spaceBtwItems),

              /// UserId
              WNProfileMenu(
                icon: Iconsax.user_octagon1,
                title: 'UserId',
                value: controller.user.value.id,
                rightIcon: Iconsax.copy,
                onPressed: () {
                  // Copy userId to clipboard
                  Clipboard.setData(ClipboardData(text: controller.user.value.id));
                  Get.snackbar('Copied', 'User ID copied to clipboard');
                },
              ),

              WNProfileMenu(
                icon: Iconsax.user,
                title: 'Name',
                value: controller.user.value.fullName,
                rightIcon: Iconsax.arrow_right_34,
                onPressed: () => Get.to(() => const ChangeNameView()),
              ),
              WNProfileMenu(
                icon: Iconsax.profile_circle,
                title: 'Username',
                value: controller.user.value.userName,
                rightIcon: Iconsax.arrow_right_34,
                  onPressed: () => Get.to(
                          ()=> UpdateSingleFieldView(
                          title: 'Update UserName',
                          fieldName: 'UserName',
                          controller: updatecontroller.username,
                          formKey: updatecontroller.updateUsernameFormKey,
                          prefixIcon: Iconsax.profile_circle,
                          onSave: ()=> updatecontroller.updateUsername())
                  ), // Add functionality if needed
              ),

              const SizedBox(height: WNSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwItems),

              /// Personal Information
              const WNSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: WNSizes.spaceBtwItems),

              WNProfileMenu(
                icon: Iconsax.profile_2user,
                title: 'Gender',
                value: controller.user.value.gender,
                rightIcon: Iconsax.arrow_right_34,
                onPressed: () => Get.to(() => const UpdateGenderView())// Add functionality if needed
              ),
              WNProfileMenu(
                icon: Iconsax.call,
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                rightIcon: Iconsax.arrow_right_34,
                onPressed: () => Get.to(
                        ()=> UpdateSingleFieldView(
                        title: 'Update Phone Number',
                        fieldName: 'Phone Number',
                        controller: updatecontroller.phoneNumber,
                        formKey: updatecontroller.updatePhoneNumberFormKey,
                        prefixIcon: Iconsax.call,
                        onSave: ()=> updatecontroller.updatePhoneNumber())
                ) , // Add functionality if needed
              ),
              WNProfileMenu(
                icon: Iconsax.calendar,
                title: 'Date of Birth',
                value: controller.user.value.dateOfBirth,
                rightIcon: Iconsax.arrow_right_34,
                onPressed: () => Get.to(() => const UpdateDateOfBirthView()),// Add functionality if needed
              ),
              WNProfileMenu(
                icon: Iconsax.location,
                title: 'Address',
                value: controller.user.value.address,
                rightIcon: Iconsax.arrow_right_34,
                onPressed: () => Get.to(
                        ()=> UpdateSingleFieldView(
                        title: 'Update Address',
                        fieldName: 'Address',
                        controller: updatecontroller.address,
                        formKey: updatecontroller.updateAddressFormKey,
                        prefixIcon: Iconsax.location,
                        onSave: ()=> updatecontroller.updateAddress())
                ), // Add functionality if needed
              ),


              const Divider(),
              const SizedBox(height: WNSizes.spaceBtwSections),

              /// Delete Account Button
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}