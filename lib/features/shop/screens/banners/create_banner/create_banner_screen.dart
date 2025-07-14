import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_banner/responsive_design/create_banner_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_banner/responsive_design/create_banner_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_banner/responsive_design/create_banner_tablet.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: CreateBannerDesktop(),
      tablet: CreateBannerTablet(),
      mobile: CreateBannerMobile(),
    );
  }
}
