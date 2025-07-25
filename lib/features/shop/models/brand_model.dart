import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';

import '../../../utils/formatters/app_formatter.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  final DateTime? createdAt;
  DateTime? updatedAt;

  // Not Mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  String get formatedCreatedDate => AppFormatter.formatDate(createdAt);

  String get formatedUpdatedDate => AppFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productsCount': productsCount = 0,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        productsCount: data['productsCount'],
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data['createdAt']?.toDate(),
        updatedAt: data['updatedAt']?.toDate(),
      );
    } else {
      return BrandModel.empty();
    }
  }

  factory BrandModel.fromJson(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      return BrandModel(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        productsCount: data['productsCount'],
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data['createdAt']?.toDate(),
        updatedAt: data['updatedAt']?.toDate(),
      );
    } else {
      return BrandModel.empty();
    }
  }

  factory BrandModel.empty() => BrandModel(id: '', name: '', image: '', isFeatured: false);
}
