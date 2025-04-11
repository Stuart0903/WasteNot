import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/update_details/update_user_details_controllers.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';

class UpdateDateOfBirthView extends StatelessWidget {
  const UpdateDateOfBirthView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserDetailsControllers());

    return Scaffold(
      appBar: WNAppBar(
        title: Text('Change Date of Birth', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text('Select your date of birth', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: WNSizes.spaceBtwItems),

            /// Date Picker
            Form(
              key: controller.updateDateOfBirthFormKey,
              child: TextFormField(
                controller: controller.dateOfBirth,
                readOnly: true, // Prevent manual editing
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Iconsax.calendar),
                ),
                onTap: () async {
                  // Show date picker
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    // Format the date as needed
                    controller.dateOfBirth.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
                validator: (value) => WNValidators.validateEmptyText('Date of Birth', value),
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateDateOfBirth(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}