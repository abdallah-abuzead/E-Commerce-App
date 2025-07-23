import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileImageAndMeta extends StatelessWidget {
  const ProfileImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User Image
              const AppImageUploader(
                right: 10,
                bottom: 20,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
                imageType: ImageType.asset,
                image: AppImages.user,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text('Admin User', style: Theme.of(context).textTheme.headlineLarge),
              const Text('support@me.com'),
              const SizedBox(height: AppSizes.spaceBtwItems),
            ],
          ),
        ],
      ),
    );
  }
}
