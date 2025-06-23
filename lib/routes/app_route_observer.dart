import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/widgets/layouts/sidebars/sidebar_controller.dart';

class AppRouteObserver extends GetObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    final SidebarController menuController = Get.put(SidebarController());
    if (previousRoute != null) {
      for (String routeName in Routes.sidebarMenuRoutes) {
        if (routeName == previousRoute.settings.name) {
          menuController.changeActiveItem(routeName);
          break;
        }
      }
    }
  }
}
