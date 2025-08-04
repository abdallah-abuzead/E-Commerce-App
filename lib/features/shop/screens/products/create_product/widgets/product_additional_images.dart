import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    required this.onTapToAddImages,
    required this.onTapToRemoveImages,
  });

  final RxList<String> additionalProductImagesURLs;
  final Function() onTapToAddImages;
  final Function(int) onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 270,
        child: Column(
          children: [
            // Section to add additional product images
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapToAddImages,
                child: AppContainer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImages.defaultMultipleImageIcon, width: 50, height: 50),
                        const Text('Add Additional Product Images'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            // Section to display images uploaded images
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(height: 70, child: _uploadedImagesOrEmptyList()),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems / 2),

                  // Add More Images Button
                  AppContainer(
                    width: 70,
                    height: 70,
                    showBorder: true,
                    border: Border.all(color: AppColors.grey),
                    color: Colors.white,
                    onTap: onTapToAddImages,
                    child: const Center(child: Icon(Iconsax.add)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadedImagesOrEmptyList() {
    return additionalProductImagesURLs.isNotEmpty ? _uploadedImages() : emptyList();
  }

  Widget _uploadedImages() {
    return ListView.separated(
      itemCount: additionalProductImagesURLs.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, _) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder: (_, i) {
        final image = additionalProductImagesURLs[i];
        return AppImageUploader(
          top: 0,
          right: 0,
          width: 70,
          height: 70,
          left: null,
          bottom: null,
          image: image,
          icon: Iconsax.trash,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapToRemoveImages(i),
        );
      },
    );
  }

  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, _) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder: (_, _) =>
          const AppContainer(color: AppColors.primaryBackground, width: 70, height: 70),
    );
  }
}
