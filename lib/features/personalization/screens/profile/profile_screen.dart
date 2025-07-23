import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/responsive_design/profile_desktop.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/responsive_design/profile_mobile.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/responsive_design/profile_tablet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: ProfileDesktop(),
      tablet: ProfileTablet(),
      mobile: ProfileMobile(),
    );
  }
}
