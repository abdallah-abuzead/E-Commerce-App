import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SiteLayoutTemplate(
        useLayout: false,
        desktop: ResetPasswordDesktopTablet(),
        mobile: ResetPasswordMobile(),
      ),
    );
  }
}
