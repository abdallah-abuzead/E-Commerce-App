import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Update Banner', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            Column(
              children: [
                GestureDetector(
                  child: const AppRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: AppColors.primaryBackground,
                    image: AppImages.defaultImage,
                    imageType: ImageType.asset,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                TextButton(onPressed: () {}, child: const Text('Select Image')),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text(
              'Make your Banner Active or Inactive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Active', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            DropdownButton<String>(
              value: 'search',
              onChanged: (String? newValue) {},
              items: const [
                DropdownMenuItem(value: 'home', child: Text('Home')),
                DropdownMenuItem(value: 'search', child: Text('Search')),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text('Update')),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
