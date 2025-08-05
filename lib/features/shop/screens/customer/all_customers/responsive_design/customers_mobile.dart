import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customers/customers_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/table/customers_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class CustomersMobile extends StatelessWidget {
  const CustomersMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomersController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            AppContainer(
              child: Column(
                children: [
                  // Table Header
                  AppTableHeader(
                    showLeftWidget: false,
                    searchController: controller.searchTextController,
                    searchOnChange: (query) => controller.searchQuery(query),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // Table
                  Obx(
                    () => controller.isLoading.value
                        ? const AppLoaderAnimation()
                        : const CustomersTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
