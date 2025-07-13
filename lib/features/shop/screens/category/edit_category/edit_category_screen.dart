import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_design/edit_category_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_design/edit_category_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_design/edit_category_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return SiteLayoutTemplate(
      desktop: EditCategoryDesktop(category: category),
      tablet: EditCategoryTablet(category: category),
      mobile: EditCategoryMobile(category: category),
    );
  }
}
