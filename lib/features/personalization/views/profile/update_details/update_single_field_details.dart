import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/update_details/update_user_details_controllers.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';

class UpdateSingleFieldView extends StatelessWidget {
  const UpdateSingleFieldView({
    super.key,
    required this.title,
    required this.fieldName,
    required this.controller,
    required this.formKey,
    this.validator,
    required this.prefixIcon,
    required this.onSave,
  });

  final String title;
  final String fieldName;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validator;
  final IconData prefixIcon;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WNAppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text('Update your $fieldName', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: WNSizes.spaceBtwItems),

            /// Form
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                  labelText: fieldName,
                  prefixIcon: Icon(prefixIcon),
                ),
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}