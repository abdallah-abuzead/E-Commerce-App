import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../models/order_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find<DashboardController>();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2024, 5, 20),
      deliveryDate: DateTime(2024, 5, 20),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime(2024, 5, 21),
      deliveryDate: DateTime(2024, 5, 21),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    ),
    OrderModel(
      id: 'CWT0052',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime(2024, 5, 22),
      deliveryDate: DateTime(2024, 5, 22),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime(2024, 5, 23),
      deliveryDate: DateTime(2024, 5, 23),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime(2024, 5, 24),
      deliveryDate: DateTime(2024, 5, 24),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
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

    for (var order in orders) {
      orderStatusData[order.status] = (orderStatusData[order.status] ?? 0) + 1;
      totalAmounts[order.status] = (totalAmounts[order.status] ?? 0) + order.totalAmount;
    }
  }
}
