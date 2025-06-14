import 'package:ecommerce_admin_panel/common/widgets/layouts/headers/app_header.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      drawer: const Drawer(),
      body: body ?? const SizedBox(),
    );
  }
}
