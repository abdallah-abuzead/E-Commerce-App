import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/settings_form.dart';
import '../widgets/settings_image_and_meta.dart';

class SettingsDesktop extends StatelessWidget {
  const SettingsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(heading: 'Settings', breadcrumbItems: ['Settings']),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pic & Metadata
                Expanded(child: SettingsImageAndMeta()),
                SizedBox(width: AppSizes.spaceBtwSections),

                // Form
                Expanded(flex: 2, child: SettingsForm()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
