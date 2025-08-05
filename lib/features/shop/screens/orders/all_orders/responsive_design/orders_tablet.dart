import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../common/widgets/loaders/app_loader_animation.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/orders/orders_controller.dart';
import '../table/orders_table.dart';

class OrdersTablet extends StatelessWidget {
  const OrdersTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Orders', breadcrumbItems: ['Orders']),
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
                        : const OrdersTable(),
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
