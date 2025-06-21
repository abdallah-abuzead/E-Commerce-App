import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/constants/app_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(Routes.login),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const Image(
          image: AssetImage(AppImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        Text(
          AppStrings.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          email,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          AppStrings.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.login),
            child: const Text(AppStrings.done),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            child: const Text(AppStrings.resendEmail),
          ),
        ),
      ],
    );
  }
}
