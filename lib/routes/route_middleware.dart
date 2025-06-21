import 'package:ecommerce_admin_panel/data/repositories/auth/auth_repository.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: Routes.login);
  }
}
