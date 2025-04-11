import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/update_details/update_user_details_controllers.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';

class UpdateGenderView extends StatelessWidget {
  const UpdateGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserDetailsControllers());

    // List of gender options
    final List<String> genderOptions = ['Male', 'Female', 'Other'];

    return Scaffold(
      appBar: WNAppBar(
        title: Text('Change Gender', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text('Select your gender', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: WNSizes.spaceBtwItems),

            /// Dropdown Menu for Gender
            Form(
              key: controller.updateGenderFormKey,
              child: DropdownButtonFormField<String>(
                value: controller.gender.text.isNotEmpty ? controller.gender.text : null,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Iconsax.profile_2user),
                ),
                items: genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.gender.text = value!;
                },
                validator: (value) => WNValidators.validateEmptyText('Gender', value),
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateGender(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}