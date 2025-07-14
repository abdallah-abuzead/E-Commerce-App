import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/brand_model.dart';
import '../widgets/edit_brand_form.dart';

class EditBrandMobile extends StatelessWidget {
  const EditBrandMobile({super.key, required this.brand});

  final BrandModel brand;

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
              heading: 'Update Brand',
              breadcrumbItems: [Routes.brands, 'Update Brand'],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            EditBrandForm(brand: brand),
          ],
        ),
      ),
    );
  }
}
