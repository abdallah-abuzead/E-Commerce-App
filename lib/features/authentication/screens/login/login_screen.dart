import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SiteLayoutTemplate(
        useLayout: false,
        desktop: LoginDesktopTablet(),
        mobile: LoginMobile(),
      ),
    );
  }
}
