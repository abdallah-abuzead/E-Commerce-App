import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../../../routes/app_screens.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/banners/edit_banner_controller.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);
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
            Text('Update Banner', style: Theme.of(context).textTheme.headlineMedium),
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
                onPressed: () => controller.updateBanner(banner),
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
