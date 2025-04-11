import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/user_conntroller.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/validators/validation.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final isGoogleUser = controller.authRepo.isGoogleUser();

    return Scaffold(
      appBar: WNAppBar(
        title: Text('Change Password', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              isGoogleUser
                  ? 'Set a new password for your account'
                  : 'Update your password',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: WNSizes.spaceBtwItems),

            /// Form
            Form(
              key: controller.updatePasswordFormKey,
              child: Column(
                children: [
                  /// Current Password (Only for Email/Password users)
                  if (!isGoogleUser)
                    TextFormField(
                      controller: controller.currentPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                      validator: (value) => WNValidators.validateEmptyText('Current Password', value),
                    ),
                  if (!isGoogleUser) const SizedBox(height: WNSizes.spaceBtwInputFields),

                  /// New Password
                  TextFormField(
                    controller: controller.newPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Iconsax.password_check),
                    ),
                    validator: (value) => WNValidators.validatePassword(value),
                  ),
                  const SizedBox(height: WNSizes.spaceBtwInputFields),

                  /// Confirm New Password
                  TextFormField(
                    controller: controller.confirmNewPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      prefixIcon: Icon(Iconsax.password_check),
                    ),
                    validator: (value) {
                      if (value != controller.newPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePassword(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}