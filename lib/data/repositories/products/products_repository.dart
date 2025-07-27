import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_category_model.dart';

class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find<ProductsRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all Products from 'products' collection
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('products').get();
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<List<ProductCategoryModel>> getProductCategories(String productId) async {
    try {
      final snapshot = await _db
          .collection('productsCategories')
          .where('productId', isEqualTo: productId)
          .get();
      return snapshot.docs.map((doc) => ProductCategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('products').doc(product.id);
        final productSnapshot = await transaction.get(productRef);
        if (!productSnapshot.exists) {
          throw 'Product does not exist';
        }

        final productCategoriesSnapshot = await _db
            .collection('productsCategories')
            .where('productId', isEqualTo: product.id)
            .get();
        final productCategories = productCategoriesSnapshot.docs
            .map((doc) => ProductCategoryModel.fromSnapshot(doc))
            .toList();

        if (productCategories.isNotEmpty) {
          for (var category in productCategories) {
            final categoryRef = _db.collection('productsCategories').doc(category.id);
            transaction.delete(categoryRef);
          }
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createProduct(ProductModel newRecord) async {
    try {
      final data = await _db.collection('products').add(newRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createProductCategory(ProductCategoryModel productCategory) async {
    try {
      final data = await _db.collection('productsCategories').add(productCategory.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateProductSpecificValue(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
