import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:wastenot/features/authentication/controllers/signUp/signup_controller.dart';
import 'package:wastenot/features/authentication/views/signup/widgets/terms_condition_checkbox.dart';
import 'package:wastenot/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class WNsignupform extends StatelessWidget {
  const WNsignupform({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => WNValidators.validateEmptyText('First Name', value),
                  expands:false,
                  decoration: InputDecoration(
                      labelText: WNTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
                  ),
                ),
              ),
              const SizedBox(width:  WNSizes.spaceBtwInputFields,),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => WNValidators.validateEmptyText('Last Name', value),
                  expands:false,
                  decoration: InputDecoration(
                      labelText: WNTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///Username
          TextFormField(
            controller: controller.userName,
            validator: (value) => WNValidators.validateEmptyText('Username', value),
            expands: false,
            decoration: InputDecoration(
                labelText: WNTexts.username,prefixIcon: Icon(Iconsax.user_edit), labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          /// Gender Dropdown
          Obx(() =>
              DropdownButtonFormField<String>(
                value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Iconsax.profile_2user),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                validator: (value) => WNValidators.validateEmptyText('Gender', value),
                items: ['Male', 'Female', 'Other', 'Prefer not to say'].map((gender) =>
                    DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    )
                ).toList(),
                onChanged: (value) {
                  if (value != null) controller.selectedGender.value = value;
                },
              ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          /// Date of Birth
          GestureDetector(
            onTap: () => controller.selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller.dateOfBirth,
                validator: (value) => WNValidators.validateEmptyText('Date of Birth', value),
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Iconsax.calendar),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///Address
          TextFormField(
            controller: controller.address,
            validator: (value) => WNValidators.validateEmptyText('Address', value),
            expands: false,
            decoration:InputDecoration(
                labelText: WNTexts.address,
                prefixIcon: Icon(Iconsax.location),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => WNValidators.validateEmail(value),
            expands: false,
            decoration: InputDecoration(
                labelText: WNTexts.email,
                prefixIcon: Icon(Iconsax.direct),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///PhoneNumber
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => WNValidators.validatePhoneNumber(value),
            expands: false,
            decoration: InputDecoration(
                labelText: WNTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///Password
          Obx(
                ()=> TextFormField(
              controller: controller.password,
              validator: (value) => WNValidators.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: WNTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: ()=> controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value? Iconsax.eye_slash : Iconsax.eye),
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          ///Termconditions Checkbox
          WNTermsAndConditioncheckbox(),
          const SizedBox(height: WNSizes.spaceBtwInputFields,),

          /// Sign Up Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=> controller.signup(),
                child: const Text(WNTexts.createAccount),
              )
          )
        ],
      ),
    );
  }
}