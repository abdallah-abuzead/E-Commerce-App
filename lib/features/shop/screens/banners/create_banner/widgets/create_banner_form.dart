import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/routes/app_screens.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/banners/create_banner_controller.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Create New Banner', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: AppRoundedImage(
                      width: 400,
                      height: 200,
                      backgroundColor: AppColors.primaryBackground,
                      image: controller.imageUrl.value.isNotEmpty
                          ? controller.imageUrl.value
                          : AppImages.defaultImage,
                      imageType: controller.imageUrl.value.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                TextButton(
                  onPressed: () => controller.pickImage(),
                  child: const Text('Select Image'),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text(
              'Make your Banner Active or Inactive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) => controller.isActive.value = value ?? false,
                child: const Text('Active', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => DropdownButton<String>(
                value: controller.targetScreen.value,
                onChanged: (String? newValue) => controller.targetScreen.value = newValue!,
                items: AppScreens.allAppScreenItems.map((String screen) {
                  return DropdownMenuItem<String>(value: screen, child: Text(screen));
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createBanner(),
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
