import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../utils/constants/enums.dart';
import 'address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.docId = '',
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Cash On Delivery',
    this.billingAddress,
    this.shippingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formatedOrderDate => HelperFunctions.getFormatedDate(orderDate);

  String get formatedDeliveryDate => HelperFunctions.getFormatedDate(deliveryDate!);

  Map<String, dynamic> toJson() {
    return {'status': status, 'totalAmount': totalAmount, 'items': items, 'orderDate': orderDate};
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return OrderModel(
        id: document.id,
        status: data['status'] ?? '',
        totalAmount: data['totalAmount'] ?? 0,
        items: data['items'] ?? [],
        orderDate: data['orderDate']?.toDate(),
      );
    } else {
      return OrderModel.empty();
    }
  }

  factory OrderModel.empty() => OrderModel(
    id: '',
    status: OrderStatus.pending,
    totalAmount: 0,
    orderDate: DateTime.now(),
    items: [],
    shippingCost: 0,
    taxCost: 0,
  );
}
