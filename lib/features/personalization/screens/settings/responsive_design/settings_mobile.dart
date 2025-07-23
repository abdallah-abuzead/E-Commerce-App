import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../widgets/settings_form.dart';
import '../widgets/settings_image_and_meta.dart';

class SettingsMobile extends StatelessWidget {
  const SettingsMobile({super.key});

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
            // Profile Pic & Metadata
            SettingsImageAndMeta(),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            SettingsForm(),
          ],
        ),
      ),
    );
  }
}
