import 'package:ecommerce_admin_panel/data/repositories/orders/orders_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';

class OrdersController extends AppBaseController<OrderModel> {
  static OrdersController get instance => Get.find<OrdersController>();

  final OrdersRepository _ordersRepository = Get.put(OrdersRepository());

  RxBool statusLoader = false.obs;
  Rx<OrderStatus> orderStatus = OrderStatus.delivered.obs;

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _ordersRepository.getAllOrders();
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _ordersRepository.deleteOrder(item.docId);
  }

  void sortById(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (order) => order.id.toLowerCase());
  }

  void sortByTotalAmount(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (order) => order.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (order) => order.orderDate.toString().toLowerCase());
  }

  /// Update product status
  Future<void> updateProductStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _ordersRepository.updateOrderSpecificValue(order.docId, {'status': newStatus.name});
      updateItemInLists(order);
      orderStatus.value = newStatus;
      AppLoaders.successSnackBar(title: 'Updated', message: 'Order status updated');
    } catch (e) {
      AppLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
