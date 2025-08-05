import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/app_loaders.dart';
import '../../models/order_model.dart';

class OrderDetailsController extends GetxController {
  static OrderDetailsController get instance => Get.find<OrderDetailsController>();

  RxBool loading = false.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  ///--- Load customer orders

  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;
      // Fetch order customer
      final user = await UserRepository.instance.fetchUserDetails(order.value.userId);
      customer.value = user;
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
