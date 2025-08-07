import 'package:ecommerce_admin_panel/data/abstract/app_base_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customers/customers_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/orders/orders_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../models/order_model.dart';

class DashboardController extends AppBaseController<OrderModel> {
  static DashboardController get instance => Get.find<DashboardController>();

  final ordersController = Get.put(OrdersController());
  final customersController = Get.put(CustomersController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  @override
  Future<List<OrderModel>> fetchItems() async {
    if (ordersController.allItems.isEmpty) {
      await ordersController.fetchItems();
    }
    if (customersController.allItems.isEmpty) {
      await customersController.fetchItems();
    }

    _calculateWeeklySales();
    _calculateOrderStatusData();

    return ordersController.allItems;
  }

  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in ordersController.allItems) {
      final DateTime orderWeekStart = HelperFunctions.getStartOfWeek(order.orderDate);
      // check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(order.orderDate)) {
        final int dayIndex = (order.orderDate.weekday - 1) % 7;
        weeklySales[dayIndex] += order.totalAmount;
      }
    }
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in ordersController.allItems) {
      orderStatusData[order.status] = (orderStatusData[order.status] ?? 0) + 1;
      totalAmounts[order.status] = (totalAmounts[order.status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {}
}
