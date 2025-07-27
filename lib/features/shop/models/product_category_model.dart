import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String? id;
  String productId;
  String categoryId;

  ProductCategoryModel({this.id, required this.productId, required this.categoryId});

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'categoryId': categoryId};
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return ProductCategoryModel(
        id: document.id,
        productId: data['productId'] ?? '',
        categoryId: data['categoryId'] ?? '',
      );
    } else {
      return ProductCategoryModel.empty();
    }
  }

  factory ProductCategoryModel.empty() => ProductCategoryModel(productId: '', categoryId: '');
}
