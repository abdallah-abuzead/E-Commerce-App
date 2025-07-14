import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../widgets/create_banner_form.dart';

class CreateBannerMobile extends StatelessWidget {
  const CreateBannerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(
              returnToPreviousScreen: true,
              heading: 'Create Banner',
              breadcrumbItems: [Routes.banners, 'Create Banner'],
            ),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            CreateBannerForm(),
          ],
        ),
      ),
    );
  }
}
