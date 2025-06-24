import 'package:flutter/material.dart';

import '../../layouts/headers/app_header.dart';
import '../../layouts/sidebars/app_sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: AppSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const AppHeader(),
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
