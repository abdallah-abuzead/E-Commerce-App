import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../utils/constants/enums.dart';
import '../../personalization/models/address_model.dart';
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

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.name,
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'billingAddress': billingAddress?.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'deliveryDate': deliveryDate,
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final Map<String, dynamic> data = snapshot.data()!;
      return OrderModel(
        docId: snapshot.id,
        id: data['id'] ?? '',
        userId: data['userId'] ?? '',
        status: data['status'] == null
            ? OrderStatus.pending
            : OrderStatus.values.firstWhere((e) => e.name == data['status']),
        totalAmount: data['totalAmount'] ?? 0,
        shippingCost: data['shippingCost'] ?? 0,
        taxCost: data['taxCost'] ?? 0,
        orderDate: data['orderDate']?.toDate() ?? DateTime.now(),
        paymentMethod: data['paymentMethod'] ?? '',
        billingAddressSameAsShipping: data['billingAddressSameAsShipping'] ?? true,
        billingAddress: data['billingAddress'] == null
            ? AddressModel.empty()
            : AddressModel.fromMap(data['billingAddress']),
        shippingAddress: data['shippingAddress'] == null
            ? AddressModel.empty()
            : AddressModel.fromMap(data['shippingAddress']),
        deliveryDate: data['deliveryDate']?.toDate(),

        items: data['items'] == null
            ? []
            : (data['items'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
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
