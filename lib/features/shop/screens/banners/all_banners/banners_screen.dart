import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_design/banners_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_design/banners_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_design/banners_tablet.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: BannersDesktop(),
      tablet: BannersTablet(),
      mobile: BannersMobile(),
    );
  }
}
