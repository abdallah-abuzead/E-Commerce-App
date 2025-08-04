import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/products/product_images_controller.dart';
import '../../../../models/product_model.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller = Get.put(ProductImagesController());
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail text
          Text('Product Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Container for Product Thumbnail
          AppContainer(
            height: 300,
            color: AppColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => AppRoundedImage(
                            width: 220,
                            height: 220,
                            image:
                                controller.selectedThumbnailImageUrl.value ??
                                AppImages.defaultSingleImageSelection,
                            imageType: controller.selectedThumbnailImageUrl.value == null
                                ? ImageType.asset
                                : ImageType.network,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(
                      onPressed: () => controller.selectThumbnailImage(),
                      child: Obx(
                        () => Text(
                          '${controller.selectedThumbnailImageUrl.value == null ? 'Add' : 'Change'} Thumbnail',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
