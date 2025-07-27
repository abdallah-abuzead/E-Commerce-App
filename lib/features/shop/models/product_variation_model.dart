import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  RxString image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  }) : image = image.obs;

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image.value,
    'description': description,
    'price': price,
    'salePrice': salePrice,
    'sku': sku,
    'stock': stock,
    'soldQuantity': soldQuantity,
    'attributeValues': attributeValues,
  };

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',
      price: double.parse((json['price'] ?? 0.0).toString()),
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      stock: json['stock'] ?? 0,
      soldQuantity: json['soldQuantity'] ?? 0,
      salePrice: double.parse((json['salePrice'] ?? 0.0).toString()),
      image: json['image'] ?? '',
      attributeValues: Map<String, String>.from(json['attributeValues']),
    );
  }
}
