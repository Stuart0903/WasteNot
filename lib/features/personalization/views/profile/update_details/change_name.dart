import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/personalization/controllers/update_details/update_name_controller.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import 'package:wastenot/utils/constants/text_strings.dart';
import 'package:wastenot/utils/validators/validation.dart';

class ChangeNameView extends StatelessWidget {
  const ChangeNameView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: WNAppBar(
        title: Text('Change your name', style: Theme.of(context).textTheme.headlineSmall,),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Heading
            Text('Use your real Name for easy Verification', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: WNSizes.spaceBtwItems),

            ///Form
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => WNValidators.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: WNTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: WNSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => WNValidators.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: WNTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: WNSizes.spaceBtwSections),

            ///Save Buton
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.updateUserName(), child: Text('Save')))


          ],

        ),
      ),
    );
  }
}
