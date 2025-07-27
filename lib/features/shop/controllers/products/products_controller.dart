import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';
import '../../../../data/repositories/products/products_repository.dart';

class ProductsController extends AppBaseController<ProductModel> {
  static ProductsController get instance => Get.find<ProductsController>();

  final ProductsRepository _productsRepository = Get.put(ProductsRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productsRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productsRepository.deleteProduct(item);
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (product) => product.title.toLowerCase());
  }

  void sortByPrice(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (product) => product.price);
  }

  void sortByStock(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (product) => product.stock);
  }

  void sortBySoldItems(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (product) => product.soldQuantity);
  }

  // Get the product price or price range foe variations
  String getProductPrice(ProductModel product) {
    // If no variations, return the simple price or the sale price if available
    if (product.productType == ProductType.single.name || product.productVariations!.isEmpty) {
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0;

      // calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        final double priceToConsider = variation.salePrice > 0
            ? variation.salePrice
            : variation.price;
        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) smallestPrice = priceToConsider;
        if (priceToConsider > largestPrice) largestPrice = priceToConsider;
      }
      return smallestPrice == largestPrice
          ? smallestPrice.toString()
          : '$smallestPrice - $largestPrice';
    }
  }

  /// Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0 || originalPrice <= 0) return null;
    final double percentage = (originalPrice - salePrice) / originalPrice * 100;
    return percentage.toStringAsFixed(0);
  }

  /// Calculate Product Stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.name
        ? product.stock.toString()
        : product.productVariations!
              .fold<int>(0, (total, variation) => total + variation.stock)
              .toString();
  }

  /// Calculate Product Sold Quantity
  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.name
        ? product.soldQuantity.toString()
        : product.productVariations!
              .fold<int>(0, (total, variation) => total + variation.soldQuantity)
              .toString();
  }

  /// Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
