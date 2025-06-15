import 'package:ecommerce_admin_panel/common/widgets/layouts/headers/app_header.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppHeader(scaffoldKey: scaffoldKey),
      drawer: const Drawer(),
      body: body ?? const SizedBox(),
    );
  }
}
