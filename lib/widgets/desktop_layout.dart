import 'package:flutter/material.dart';

import '../app_container.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: const Drawer()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // header
                AppContainer(
                  height: 75,
                  color: Colors.yellow.withValues(alpha: 0.2),
                ),
                // body
                body ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
