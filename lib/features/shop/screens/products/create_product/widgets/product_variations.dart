import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/create_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controllers/products/product_images_controller.dart';
import '../../../../models/product_variation_model.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductVariationsController variationsController = ProductVariationsController.instance;

    return Obx(
      () => CreateProductController.instance.productType.value == ProductType.variable
          ? AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product variations header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Variations', style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () => variationsController.removeVariations(context),
                        child: const Text('Remove Variations'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  variationsController.productVariations.isNotEmpty
                      // Variations List
                      ? ListView.separated(
                          itemCount: variationsController.productVariations.length,
                          shrinkWrap: true,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSizes.spaceBtwItems),
                          itemBuilder: (_, i) {
                            final variation = variationsController.productVariations[i];
                            return _buildVariationsTile(
                              context,
                              i,
                              variation,
                              variationsController,
                            );
                          },
                        )
                      :
                        // No variation message
                        _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildVariationsTile(
    BuildContext context,
    int index,
    ProductVariationModel variation,
    ProductVariationsController variationsController,
  ) {
    return ExpansionTile(
      backgroundColor: AppColors.lightGrey,
      collapsedBackgroundColor: AppColors.lightGrey,
      childrenPadding: const EdgeInsets.all(AppSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries.map((e) => '${e.key}: ${e.value}').join(', ')),
      children: [
        // upload variation image
        Obx(
          () => AppImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.value.isNotEmpty ? ImageType.network : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : AppImages.defaultImage,
            onIconButtonPressed: () =>
                ProductImagesController.instance.selectVariationImage(variation),
          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwInputFields),

        // Variations Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: variationsController.stockControllersList[index][variation],
                onChanged: (value) => variation.stock = int.parse(value),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: variationsController.priceControllersList[index][variation],
                onChanged: (value) => variation.price = double.parse(value),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: variationsController.salePriceControllersList[index][variation],
                onChanged: (value) => variation.salePrice = double.parse(value),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),

        // Variations description
        TextFormField(
          controller: variationsController.descriptionControllersList[index][variation],
          onChanged: (value) => variation.description = value,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add description of this variation...',
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: AppImages.defaultVariationsImageIcon,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        Text('There are no variations added for this product'),
      ],
    );
  }
}
