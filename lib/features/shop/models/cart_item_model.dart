class CartItemModel {
  final String productId;
  final String title;
  final double price;
  final String? image;
  final int quantity;
  final String variationId;
  final String? brandName;
  final Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  /// calculate total amount
  String get totalAmount => (price * quantity).toStringAsFixed(1);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'description': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }

  factory CartItemModel.empty() => CartItemModel(productId: '', quantity: 0);
}
