import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../widgets/edit_banner_form.dart';

class EditBannerDesktop extends StatelessWidget {
  const EditBannerDesktop({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const BreadcrumbWithHeading(
              returnToPreviousScreen: true,
              heading: 'Update Banner',
              breadcrumbItems: [Routes.brands, 'Update Banner'],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            EditBannerForm(banner: banner),
          ],
        ),
      ),
    );
  }
}
