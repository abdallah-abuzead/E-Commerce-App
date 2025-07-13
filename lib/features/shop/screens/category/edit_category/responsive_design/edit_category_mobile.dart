import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/category_model.dart';
import '../widgets/edit_category_form.dart';

class EditCategoryMobile extends StatelessWidget {
  const EditCategoryMobile({super.key, required this.category});

  final CategoryModel category;

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
              heading: 'Update Category',
              breadcrumbItems: [Routes.categories, 'Update Category'],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Form
            EditCategoryForm(category: category),
          ],
        ),
      ),
    );
  }
}
