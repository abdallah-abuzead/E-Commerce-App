import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../common/widgets/loaders/app_loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/banners/banners_controller.dart';
import '../table/data_table.dart';

class BannersMobile extends StatelessWidget {
  const BannersMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannersController());

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
            Obx(
              () => controller.isLoading.value
                  ? const AppLoaderAnimation()
                  : AppContainer(
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
            ),
          ],
        ),
      ),
    );
  }
}
