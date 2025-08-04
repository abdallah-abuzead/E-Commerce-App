import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/products/product_images_controller.dart';
import '../../../../models/product_model.dart';
import '../widgets/product_additional_images.dart';
import '../widgets/product_attributes.dart';
import '../widgets/product_bottom_navigation_buttons.dart';
import '../widgets/product_brand.dart';
import '../widgets/product_categories.dart';
import '../widgets/product_stock_and_pricing.dart';
import '../widgets/product_thumbnail_image.dart';
import '../widgets/product_title_and_description.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/product_variations.dart';
import '../widgets/product_visibility_widget.dart';

class EditProductDesktop extends StatelessWidget {
  const EditProductDesktop({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller = Get.put(ProductImagesController());

    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Product',
                breadcrumbItems: [Routes.products, 'Update Product'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: DeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        ProductTitleAndDescription(product: product),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Stock & Pricing
                        AppContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Heading
                              Text(
                                'Stock & Pricing',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems),

                              // Product Type
                              ProductTypeWidget(product: product),
                              const SizedBox(height: AppSizes.spaceBtwInputFields),

                              // Stock
                              ProductStockAndPricing(product: product),
                              const SizedBox(height: AppSizes.spaceBtwSections),

                              // Attributes
                              ProductAttributes(product: product),
                              const SizedBox(height: AppSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Variations
                        ProductVariations(product: product),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppSizes.defaultSpace),

                  Expanded(
                    child: Column(
                      children: [
                        // Product Thumbnail
                        ProductThumbnailImage(product: product),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Images
                        AppContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems),
                              ProductAdditionalImages(
                                product: product,
                                additionalProductImagesURLs: controller.additionalProductImagesUrls,
                                onTapToAddImages: () => controller.selectMultipleProductImages(),
                                onTapToRemoveImages: (index) => controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Brand
                        ProductBrand(product: product),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Categories
                        ProductCategories(product: product),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Visibility
                        ProductVisibilityWidget(product: product),
                        const SizedBox(height: AppSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
