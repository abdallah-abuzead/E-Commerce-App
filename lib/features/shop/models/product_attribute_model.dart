class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  Map<String, dynamic> toJson() => {'name': name, 'values': values};

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] ?? '',
      values: List<String>.from(json['values']),
    );
  }
}
