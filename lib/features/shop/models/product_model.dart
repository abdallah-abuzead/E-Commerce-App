import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';

import '../../../utils/formatters/app_formatter.dart';
import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String? productType;
  String? description;
  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  String get formatedDate => AppFormatter.formatDate(date);

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'soldQuantity': soldQuantity,
      'productAttributes': productAttributes == null
          ? []
          : productAttributes!.map((e) => e.toJson()).toList(),
      'productVariations': productVariations == null
          ? []
          : productVariations!.map((e) => e.toJson()).toList(),
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return ProductModel(
        id: document.id,
        title: data['title'],
        price: double.parse((data['price'] ?? 0.0).toString()),
        sku: data['sku'],
        stock: data['stock'] ?? 0,
        soldQuantity: data['soldQuantity'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        productType: data['productType'] ?? '',
        brand: BrandModel.fromJson(data['date']),
        images: List<String>.from(data['images'] ?? []),
        productAttributes: (data['productAttributes'] as List)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['productVariations'] as List)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
      );
    } else {
      return ProductModel.empty();
    }
  }

  /// for streams
  factory ProductModel.fromSQueryDocumentSnapshot(QueryDocumentSnapshot<Object?> document) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['title'],
      price: double.parse((data['price'] ?? 0.0).toString()),
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      soldQuantity: data['soldQuantity'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromJson(data['date']),
      images: List<String>.from(data['images'] ?? []),
      productAttributes: (data['productAttributes'] as List)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['productVariations'] as List)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.empty() =>
      ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');
}
