import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class EditCategoryDesktop extends StatelessWidget {
  const EditCategoryDesktop({super.key, required this.category});

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
