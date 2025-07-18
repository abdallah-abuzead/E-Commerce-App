import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/responsive_design/edit_product_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/responsive_design/edit_product_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    return SiteLayoutTemplate(
      desktop: EditProductDesktop(product: product),
      mobile: EditProductMobile(product: product),
    );
  }
}
