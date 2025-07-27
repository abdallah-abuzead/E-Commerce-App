import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/table/products_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../common/widgets/loaders/app_loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/products/products_controller.dart';

class ProductsTablet extends StatelessWidget {
  const ProductsTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.put(ProductsController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Products', breadcrumbItems: ['Products']),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            Obx(
              () => controller.isLoading.value
                  ? const AppLoaderAnimation()
                  : AppContainer(
                      child: Column(
                        children: [
                          // Table Header
                          AppTableHeader(
                            buttonText: 'Add Product',
                            onPressed: () => Get.toNamed(Routes.createProduct),
                            searchOnChange: (query) => controller.searchQuery(query),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),

                          // Table
                          const ProductsTable(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
