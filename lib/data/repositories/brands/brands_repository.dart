import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exeptions.dart';
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
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  // Get all brands categories from 'brandsCategories' collection for a specific brand
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(String brandId) async {
    try {
      final snapshot = await _db
          .collection('brandsCategories')
          .where('brandId', isEqualTo: brandId)
          .get();
      return snapshot.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
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
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createBrandCategory(BrandCategoryModel newRecord) async {
    try {
      final data = await _db.collection('brandsCategories').add(newRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection('brands').doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection('brands').doc(brand.id);
        final brandSnapshot = await transaction.get(brandRef);
        if (!brandSnapshot.exists) {
          throw 'Brand does not exist';
        }

        final brandCategoriesSnapshot = await _db
            .collection('brandsCategories')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCategoriesSnapshot.docs
            .map((doc) => BrandCategoryModel.fromSnapshot(doc))
            .toList();

        if (brandCategories.isNotEmpty) {
          for (var category in brandCategories) {
            final categoryRef = _db.collection('brandsCategories').doc(category.id);
            transaction.delete(categoryRef);
          }
        }

        transaction.delete(brandRef);
      });
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteBrandCategory(String id) async {
    try {
      await _db.collection('brandsCategories').doc(id).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
