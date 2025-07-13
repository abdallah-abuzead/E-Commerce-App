import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_design/brands_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_design/brands_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_design/brands_tablet.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: BrandsDesktop(),
      tablet: BrandsTablet(),
      mobile: BrandsMobile(),
    );
  }
}
