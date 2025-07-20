import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../utils/constants/enums.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.deliveryDate,
  });

  String get formatedOrderDate => HelperFunctions.getFormatedDate(orderDate);

  String get formatedDeliveryDate => HelperFunctions.getFormatedDate(deliveryDate!);
}
