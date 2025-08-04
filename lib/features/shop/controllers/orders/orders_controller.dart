import 'package:ecommerce_admin_panel/data/repositories/orders/orders_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';

class OrdersController extends AppBaseController<OrderModel> {
  static OrdersController get instance => Get.find<OrdersController>();

  final OrdersRepository _ordersRepository = Get.put(OrdersRepository());

  void sortByName(int columnIndex, bool ascending) {
    // sortByProperty(columnIndex, ascending, (category) => category.name.toLowerCase());
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return false;
    // return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _ordersRepository.deleteOrder(item.id);
  }

  @override
  Future<List<OrderModel>> fetchItems() async {
    return await _ordersRepository.getAllOrders();
  }
}
