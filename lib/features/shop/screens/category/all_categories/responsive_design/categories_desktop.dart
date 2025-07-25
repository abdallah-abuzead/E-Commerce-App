import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../controllers/categories/categories_controller.dart';

class CategoriesDesktop extends StatelessWidget {
  const CategoriesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoriesController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Categories', breadcrumbItems: ['Categories']),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            AppContainer(
              child: Column(
                children: [
                  // Table Header
                  AppTableHeader(
                    buttonText: 'Create New Category',
                    onPressed: () => Get.toNamed(Routes.createCategory),
                    searchController: controller.searchTextController,
                    searchOnChange: (query) => controller.searchQuery(query),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // Table
                  Obx(() {
                    if (controller.isLoading.value) return const AppLoaderAnimation();
                    return const CategoryTable();
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
