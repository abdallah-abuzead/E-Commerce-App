import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/responsive_design/create_product_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/responsive_design/create_product_mobile.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(desktop: CreateProductDesktop(), mobile: CreateProductMobile());
  }
}
