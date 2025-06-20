import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          width: 100,
          height: 100,
          image: AssetImage(AppImages.darkAppLogo),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        Text(
          AppStrings.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          AppStrings.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
