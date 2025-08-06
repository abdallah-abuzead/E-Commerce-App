import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsImageAndMeta extends StatelessWidget {
  const SettingsImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // App logo
              Obx(
                () => AppImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateAppLogo(),
                  imageType: controller.settings.value.appLogo.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.settings.value.appLogo.isNotEmpty
                      ? controller.settings.value.appLogo
                      : AppImages.defaultImage,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Obx(
                () => Text(
                  controller.settings.value.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ],
      ),
    );
  }
}
