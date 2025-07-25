import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../common/widgets/loaders/app_loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/categories/categories_controller.dart';
import '../table/data_table.dart';

class CategoriesMobile extends StatelessWidget {
  const CategoriesMobile({super.key});

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
