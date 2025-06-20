import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final bool isAuthenticated = true;
    return isAuthenticated ? null : RouteSettings(name: Routes.login);
  }
}
