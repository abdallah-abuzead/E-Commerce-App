import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brands/brands_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../table/data_table.dart';

class BrandsDesktop extends StatelessWidget {
  const BrandsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandsController controller = Get.put(BrandsController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Brands', breadcrumbItems: ['Brands']),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            AppContainer(
              child: Column(
                children: [
                  // Table Header
                  AppTableHeader(
                    buttonText: 'Create New Brand',
                    onPressed: () => Get.toNamed(Routes.createBrand),
                    searchController: controller.searchTextController,
                    searchOnChange: (query) => controller.searchQuery(query),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // Table
                  Obx(() {
                    return controller.isLoading.value
                        ? const AppLoaderAnimation()
                        : const BrandsTable();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
