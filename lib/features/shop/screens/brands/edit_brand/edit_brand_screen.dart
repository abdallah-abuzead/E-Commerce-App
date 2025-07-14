import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_design/edit_brand_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_design/edit_brand_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_design/edit_brand_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandModel brand = Get.arguments;
    return SiteLayoutTemplate(
      desktop: EditBrandDesktop(brand: brand),
      tablet: EditBrandTablet(brand: brand),
      mobile: EditBrandMobile(brand: brand),
    );
  }
}
