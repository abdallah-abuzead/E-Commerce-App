import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileImageAndMeta extends StatelessWidget {
  const ProfileImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Column(
              children: [
                // User Image
                AppImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateProfilePicture(),
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : AppImages.user,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  controller.user.value.fullName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(controller.user.value.email),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
