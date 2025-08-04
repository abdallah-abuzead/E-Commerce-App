class CartItemModel {
  final String? id;
  final String title;
  final String description;
  final double price;
  final double quantity;
  final double totalAmount;
  final String? image;
  final Map<String, dynamic>? selectedVariations;

  CartItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    this.totalAmount = 0,
    this.image,
    this.selectedVariations,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imageUrl': image,
    };
  }
}
