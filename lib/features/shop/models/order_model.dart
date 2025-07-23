import 'package:ecommerce_admin_panel/features/shop/models/item_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../utils/constants/enums.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final List<ItemModel> items;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    this.items = const [],
    required this.orderDate,
    this.deliveryDate,
    this.paymentMethod = 'Cash on Delivery',
  });

  String get formatedOrderDate => HelperFunctions.getFormatedDate(orderDate);

  String get formatedDeliveryDate => HelperFunctions.getFormatedDate(deliveryDate!);
}
