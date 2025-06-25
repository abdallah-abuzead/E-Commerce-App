import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../routes/routes.dart';

class MediaDesktop extends StatelessWidget {
  const MediaDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSizes.defaultSpace),
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
                BreadcrumbWithHeading(
                  heading: 'Media',
                  breadcrumbItems: [Routes.login, Routes.forgetPassword, 'Media Screen'],
                ),
              ],
            ),
            SizedBox(height: AppSizes.spaceBtwSections),

            /// Upload area

            /// Media
          ],
        ),
      ),
    );
  }
}
