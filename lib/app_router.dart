import 'package:ecommerce_admin_panel/screens/home_screen.dart';
import 'package:ecommerce_admin_panel/screens/responsive_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String home = '/';
  static const String responsiveDesign = '/responsive-design';

  static final List<GetPage> pages = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: responsiveDesign, page: () => ResponsiveDesignScreen()),
  ];

  static final unknownRoute = GetPage(
    name: '/not-found',
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
