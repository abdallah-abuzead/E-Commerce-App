import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_design/create_brand_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_design/create_brand_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_design/create_brand_tablet.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: CreateBrandDesktop(),
      tablet: CreateBrandTablet(),
      mobile: CreateBrandMobile(),
    );
  }
}
