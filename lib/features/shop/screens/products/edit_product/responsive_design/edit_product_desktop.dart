import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_additional_images.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_brand.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_categories.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_thumbnail_image.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_visibility_widget.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/product_model.dart';
import '../widgets/product_attributes.dart';
import '../widgets/product_bottom_navigation_buttons.dart';
import '../widgets/product_stock_and_pricing.dart';
import '../widgets/product_title_and_description.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/product_variations.dart';

class EditProductDesktop extends StatelessWidget {
  const EditProductDesktop({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
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
                        const ProductTitleAndDescription(),
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
                              const ProductTypeWidget(),
                              const SizedBox(height: AppSizes.spaceBtwInputFields),

                              // Stock
                              const ProductStockAndPricing(),
                              const SizedBox(height: AppSizes.spaceBtwSections),

                              // Attributes
                              const ProductAttributes(),
                              const SizedBox(height: AppSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppSizes.defaultSpace),

                  Expanded(
                    child: Column(
                      children: [
                        // Product Thumbnail
                        const ProductThumbnailImage(),
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
                                additionalProductImagesURLs: RxList<String>.empty(),
                                onTapToAddImages: () {},
                                onTapToRemoveImages: (index) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Brand
                        const ProductBrand(),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Categories
                        const ProductCategories(),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Visibility
                        const ProductVisibilityWidget(),
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
