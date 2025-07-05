import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/image_details_popup.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../common/widgets/loaders/app_animation_loader_widget.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../controllers/media_controller.dart';
import '../../models/image_model.dart';
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
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Show media
          Obx(() {
            final List<ImageModel> images = _getSelectedFolderImages(controller);
            if (controller.loading.value && images.isEmpty) return const AppLoaderAnimation();
            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: AppSizes.spaceBtwItems / 2,
                  runSpacing: AppSizes.spaceBtwItems / 2,
                  children: images
                      .map(
                        (image) => GestureDetector(
                          onTap: () => Get.dialog(ImageDetailsPopup(image: image)),
                          child: SizedBox(
                            width: 140,
                            height: 180,
                            child: Column(
                              children: [
                                _buildSimpleList(image),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                                    child: Text(
                                      image.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                /// Load more media button
                if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            icon: const Icon(Iconsax.arrow_down),
                            label: const Text('Load More'),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages.where((image) => image.url.isNotEmpty).toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.lg * 3),
      child: AppAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: AppImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return AppRoundedImage(
      width: 140,
      height: 140,
      padding: AppSizes.sm,
      imageType: ImageType.network,
      image: image.url,
      margin: AppSizes.spaceBtwItems / 2,
      backgroundColor: AppColors.primaryBackgroundColor,
    );
  }
}
