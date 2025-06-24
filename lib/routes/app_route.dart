import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:ecommerce_admin_panel/responsive_design_screen.dart';
import 'package:ecommerce_admin_panel/routes/route_middleware.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/shop/screens/dashboard/dashboard_screen.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [RouteMiddleware()],
    ),
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
