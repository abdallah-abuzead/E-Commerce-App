import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
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

class CreateProductMobile extends StatelessWidget {
  const CreateProductMobile({super.key});

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
                heading: 'Create Product',
                breadcrumbItems: [Routes.products, 'Create Product'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Create Product
              Column(
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
                        Text('Stock & Pricing', style: Theme.of(context).textTheme.headlineSmall),
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
                  const SizedBox(width: AppSizes.defaultSpace),

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
            ],
          ),
        ),
      ),
    );
  }
}
