import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/enums.dart';
import '../../controllers/media_controller.dart';
import 'media_folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaController controller = MediaController.instance;
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media images header
          Row(
            children: [
              Text('Selected Folder', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: AppSizes.spaceBtwItems),
              MediaFolderDropdown(
                onChanged: (newValue) {
                  if (newValue != null) controller.selectedPath.value = newValue;
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Show media
          Wrap(
            alignment: WrapAlignment.start,
            spacing: AppSizes.spaceBtwItems / 2,
            runSpacing: AppSizes.spaceBtwItems / 2,
            children: List.generate(
              10,
              (index) => const AppRoundedImage(
                width: 90,
                height: 90,
                padding: AppSizes.sm,
                imageType: ImageType.asset,
                image: AppImages.user,
                backgroundColor: AppColors.primaryBackgroundColor,
              ),
            ),
          ),

          /// Load more media button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSizes.buttonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_down),
                    label: const Text('Load More'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
