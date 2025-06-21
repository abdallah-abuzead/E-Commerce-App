import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/constants/app_strings.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          AppStrings.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          AppStrings.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections * 2),

        Form(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: AppStrings.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections * 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(
              Routes.resetPassword,
              parameters: {'email': 'some@email.com'},
            ),
            child: const Text(AppStrings.submit),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections * 2),
      ],
    );
  }
}
