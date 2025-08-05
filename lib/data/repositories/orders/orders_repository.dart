import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrdersRepository extends GetxController {
  static OrdersRepository get instance => Get.find<OrdersRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all orders from 'orders' collection
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snapshot = await _db.collection('orders').orderBy('orderDate', descending: true).get();
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      await _db.collection('orders').doc(id).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createOrder(OrderModel newRecord) async {
    try {
      final data = await _db.collection('orders').add(newRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateOrderSpecificValue(String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection('orders').doc(orderId).update(data);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
