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
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadPreviousSelection = false;
    final MediaController controller = MediaController.instance;
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media images header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              if (allowSelection) _buildAddSelectedImagesButton(),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Show media
          Obx(() {
            final List<ImageModel> images = _getSelectedFolderImages(controller);
            if (!loadPreviousSelection) {
              if (alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty) {
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);
                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadPreviousSelection = true;
            }

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
                                allowSelection
                                    ? _buildListWithCheckbox(image)
                                    : _buildSimpleList(image),
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
      backgroundColor: AppColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        AppRoundedImage(
          width: 140,
          height: 140,
          padding: AppSizes.sm,
          imageType: ImageType.network,
          image: image.url,
          margin: AppSizes.spaceBtwItems / 2,
          backgroundColor: AppColors.primaryBackground,
        ),
        Positioned(
          top: AppSizes.md,
          right: AppSizes.md,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;
                  if (selected) {
                    if (!allowMultipleSelection) {
                      for (var otherImage in selectedImages) {
                        if (image != otherImage) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: const Text('Close'),
            icon: const Icon(Iconsax.close_circle),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
          ),
        ),
      ],
    );
  }
}
