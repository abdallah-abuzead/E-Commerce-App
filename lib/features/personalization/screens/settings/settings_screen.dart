import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/responsive_design/settings_desktop.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/responsive_design/settings_mobile.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/responsive_design/settings_tablet.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: SettingsDesktop(),
      tablet: SettingsTablet(),
      mobile: SettingsMobile(),
    );
  }
}
