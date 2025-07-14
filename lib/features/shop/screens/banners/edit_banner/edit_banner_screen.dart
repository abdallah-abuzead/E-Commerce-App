import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_design/edit_banner_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_design/edit_banner_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_design/edit_banner_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerModel banner = Get.arguments;
    return SiteLayoutTemplate(
      desktop: EditBannerDesktop(banner: banner),
      tablet: EditBannerTablet(banner: banner),
      mobile: EditBannerMobile(banner: banner),
    );
  }
}
