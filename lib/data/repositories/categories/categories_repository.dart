import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoriesRepository extends GetxController {
  static CategoriesRepository get instance => Get.find<CategoriesRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all categories from 'categories' collection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _db.collection('categories').doc(id).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
