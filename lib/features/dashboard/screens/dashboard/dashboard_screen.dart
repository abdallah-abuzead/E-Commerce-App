import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/dashboard/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:ecommerce_admin_panel/features/dashboard/screens/dashboard/responsive_screens/dashboard_mobile.dart';
import 'package:ecommerce_admin_panel/features/dashboard/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: DashboardDesktop(),
      tablet: DashboardTablet(),
      mobile: DashboardMobile(),
    );
  }
}
