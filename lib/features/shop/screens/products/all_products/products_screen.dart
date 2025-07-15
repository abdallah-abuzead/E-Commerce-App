import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_design/products_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_design/products_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_design/products_tablet.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: ProductsDesktop(),
      tablet: ProductsTablet(),
      mobile: ProductsMobile(),
    );
  }
}
