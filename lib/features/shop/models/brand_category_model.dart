import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String? id;
  String brandId;
  String categoryId;

  BrandCategoryModel({this.id, required this.brandId, required this.categoryId});

  Map<String, dynamic> toJson() {
    return {'brandId': brandId, 'categoryId': categoryId};
  }

  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return BrandCategoryModel(
        id: document.id,
        brandId: data['brandId'] ?? '',
        categoryId: data['categoryId'] ?? '',
      );
    } else {
      return BrandCategoryModel.empty();
    }
  }

  factory BrandCategoryModel.empty() => BrandCategoryModel(brandId: '', categoryId: '');
}
