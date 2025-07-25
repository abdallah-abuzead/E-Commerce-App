import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/app_formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  final DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  String get formatedCreatedDate => AppFormatter.formatDate(createdAt);

  String get formatedUpdatedDate => AppFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        parentId: data['parentId'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data['createdAt']?.toDate(),
        updatedAt: data['updatedAt']?.toDate(),
      );
    } else {
      return CategoryModel.empty();
    }
  }

  factory CategoryModel.empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);
}
