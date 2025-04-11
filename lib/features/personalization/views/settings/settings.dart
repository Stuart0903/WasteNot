import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:wastenot/common/widgets/images/circular_image.dart';
import 'package:wastenot/common/widgets/list_tiles/settings_menu_title.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/nav_menu/shop/controllers/redeemption_controller.dart';
import 'package:wastenot/features/personalization/controllers/settings_controller.dart';
import 'package:wastenot/features/personalization/views/profile/update_details/change_password_view.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/features/personalization/views/profile/profile.dart';
import 'package:wastenot/features/personalization/views/settings/widgets/reward_details.dart';
import 'package:wastenot/utils/constants/image_strings.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/helpers/helpers.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final redeemController = Get.put(RedeemptionController());

    // Create a local observable variable for dark mode
    final isDarkMode = WNHelperFunctions.isDarkMode(context).obs;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                ///Header
                WNPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        ///App Bar
                        WNAppBar(
                          title: Text('Account Section', style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
                        ),
                        const SizedBox(height: WNSizes.spaceBtwItems,),

                        ///UserProfileCard
                        Obx(
                          () {
                            final profileImageUrl = userController.user.value.profilePicture;
                            print('Profile Image: $profileImageUrl');
                              return ListTile(
                                leading: WNCircularImage(
                                  image: profileImageUrl.isNotEmpty
                                      ? profileImageUrl
                                      : WNImages.lightAppLogo,
                                  // Default local asset
                                  isNetworkImage: profileImageUrl.isNotEmpty,
                                  // Use network image if URL is available
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(userController.user.value.fullName,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: Colors.white)),
                                subtitle: Text(userController.user.value.email,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: Colors.white)),
                                trailing: IconButton(onPressed: () =>
                                    Get.to(() => const ProfileView()),
                                    icon: const Icon(Iconsax.edit, color: Colors
                                        .white)),
                              );
                            }),
                        const SizedBox(height: WNSizes.spaceBtwSections),
                      ],
                    )
                ),
                /// BODY
                Padding(
                  padding: const EdgeInsets.all(WNSizes.defaultSpace),
                  child: Column(
                      children: [
                        ///Account Settings
                        const WNSectionHeading(title: 'Account Settings', showActionButton: false),
                        const SizedBox(height: WNSizes.spaceBtwItems),

                        // Profile Information
                        WNSettingsMenuTile(
                          icon: Iconsax.user,
                          title: 'Profile Information',
                          subtitle: 'View and edit your profile details',
                          onTap: () => Get.to(() => const ProfileView()),
                        ),

                        // My Rewards
                        WNSettingsMenuTile(
                          icon: Iconsax.medal_star,
                          title: 'My Rewards',
                          subtitle: 'View reward details, history and total points',
                          onTap: () async {
                            await redeemController.getUserVoucherData();
                            // Navigate to RewardsView
                            Get.to(() => const RewardsView());
                          },
                        ),

                        // Change Password
                        WNSettingsMenuTile(
                          icon: Iconsax.password_check,
                          title: 'Change Password',
                          subtitle: 'Update your password',
                          onTap: ()=> Get.to(() => const ChangePasswordView())
                        ),

                        // Address Management
                        WNSettingsMenuTile(
                          icon: Iconsax.location,
                          title: 'Addresses',
                          subtitle: 'Manage your delivery addresses',
                          onTap: () {
                            // Implement address management
                          },
                        ),

                        // Logout Button
                        WNSettingsMenuTile(
                          icon: Iconsax.logout,
                          title: 'Logout',
                          subtitle: 'Sign out from your account',
                          onTap: () => userController.logoutPopUp(),
                        ),

                        const SizedBox(height: WNSizes.spaceBtwSections),

                        ///App Preferences
                        const WNSectionHeading(title: 'App Preferences', showActionButton: false),
                        const SizedBox(height: WNSizes.spaceBtwItems),

                        // Language Selection
                        WNSettingsMenuTile(
                          icon: Iconsax.language_square,
                          title: 'Language',
                          subtitle: 'Select your preferred language',
                          trailing: DropdownButton<String>(
                            value: 'English',
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(value: 'English', child: Text('English')),
                              DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
                              DropdownMenuItem(value: 'French', child: Text('French')),
                            ],
                            onChanged: (value) {
                              // Handle language change
                            },
                          ),
                          onTap: () {},
                        ),

                        // Theme Mode with working toggle - Fixed version
                        Obx(() => WNSettingsMenuTile(
                          icon: isDarkMode.value ? Iconsax.moon : Iconsax.sun_1,
                          title: 'Dark Mode',
                          subtitle: isDarkMode.value
                              ? 'Switch to light theme'
                              : 'Switch to dark theme',
                          trailing: Switch(
                            value: isDarkMode.value,
                            onChanged: (value) {
                              // Update the observable
                              isDarkMode.value = value;
                              // Set the theme mode based on the switch value
                              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                            },
                          ),
                          onTap: () {
                            // Toggle theme when the tile is tapped
                            isDarkMode.value = !isDarkMode.value;
                            Get.changeThemeMode(
                                isDarkMode.value ? ThemeMode.dark : ThemeMode.light
                            );
                          },
                        )),

                        const SizedBox(height: WNSizes.spaceBtwSections),

                        ///Notification Settings
                        const WNSectionHeading(title: 'Notification Settings', showActionButton: false),
                        const SizedBox(height: WNSizes.spaceBtwItems),

                        // Push Notifications Toggle
                        WNSettingsMenuTile(
                          icon: Iconsax.notification,
                          title: 'Push Notifications',
                          subtitle: 'Enable or disable push notifications',
                          trailing: Switch(
                            value: true, // Replace with actual value from controller
                            onChanged: (value) {
                              // Handle push notification toggle
                            },
                          ),
                          onTap: () {},
                        ),
                      ]
                  ),
                )
              ],
            )
        )
    );
  }
}