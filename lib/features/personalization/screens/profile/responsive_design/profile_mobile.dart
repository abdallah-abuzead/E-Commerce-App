import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../widgets/profile_form.dart';
import '../widgets/profile_image_and_meta.dart';

class ProfileMobile extends StatelessWidget {
  const ProfileMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(heading: 'Profile', breadcrumbItems: ['Profile']),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Body
            // Profile Pic & Metadata
            ProfileImageAndMeta(),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            ProfileForm(),
          ],
        ),
      ),
    );
  }
}
