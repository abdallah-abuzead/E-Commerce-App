import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_content.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../routes/routes.dart';
import '../../controllers/media_controller.dart';

class MediaDesktop extends StatelessWidget {
  const MediaDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Breadcrumbs
                const BreadcrumbWithHeading(
                  heading: 'Media',
                  breadcrumbItems: [Routes.login, 'Media Screen'],
                ),
                SizedBox(
                  width: AppSizes.buttonWidth * 1.5,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.showImagesUploaderSection.value =
                        !controller.showImagesUploaderSection.value,
                    icon: const Icon(Iconsax.cloud_add),
                    label: const Text('Upload Images'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Upload area
            const MediaUploader(),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Media
            MediaContent(allowSelection: false, allowMultipleSelection: false),
          ],
        ),
      ),
    );
  }
}
