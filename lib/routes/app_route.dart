import 'package:ecommerce_admin_panel/home_screen.dart';
import 'package:ecommerce_admin_panel/responsive_design_screen.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(
      name: Routes.responsiveDesign,
      page: () => ResponsiveDesignScreen(),
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
