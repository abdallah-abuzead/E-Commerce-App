import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../table/data_table.dart';

class BannersTablet extends StatelessWidget {
  const BannersTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(heading: 'Banners', breadcrumbItems: ['Banners']),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            AppContainer(
              child: Column(
                children: [
                  // Table Header
                  AppTableHeader(
                    buttonText: 'Create New Banner',
                    onPressed: () => Get.toNamed(Routes.createBanner),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // Table
                  const BannersTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
