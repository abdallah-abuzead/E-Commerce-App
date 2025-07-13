import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/all_categories/responsive_design/categories_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/all_categories/responsive_design/categories_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/all_categories/responsive_design/categories_tablet.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: CategoriesDesktop(),
      tablet: CategoriesTablet(),
      mobile: CategoriesMobile(),
    );
  }
}
