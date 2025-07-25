import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../features/shop/models/brand_model.dart';

class BrandsRepository extends GetxController {
  static BrandsRepository get instance => Get.find<BrandsRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all brands from 'brands' collection
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('brands').get();
      return snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  // Get all brands categories from 'brandsCategories' collection
  Future<List<BrandCategoryModel>> getAllBrandsCategories() async {
    try {
      final snapshot = await _db.collection('brandsCategories').get();
      return snapshot.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteBrand(String id) async {
    try {
      await _db.collection('brands').doc(id).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createBrand(BrandModel newRecord) async {
    try {
      final data = await _db.collection('brands').add(newRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateBrand(BrandModel category) async {
    try {
      await _db.collection('brands').doc(category.id).update(category.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
