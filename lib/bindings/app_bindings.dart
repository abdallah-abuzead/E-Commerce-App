import 'package:ecommerce_admin_panel/data/services/network_manager.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkManager>(() => NetworkManager(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
  }
}
