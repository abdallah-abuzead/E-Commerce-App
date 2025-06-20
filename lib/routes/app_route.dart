import 'package:ecommerce_admin_panel/responsive_design_screen.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(
      name: Routes.responsiveDesign,
      page: () => const ResponsiveDesignScreen(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: Routes.unknown,
    page: () => const UnknownRouteScreen(),
  );
}

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(child: Text('404 - Page Not Found')),
    );
  }
}
