import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import '../../../../data/abstract/app_base_controller.dart';
import '../../../../data/repositories/brands/brands_repository.dart';
import '../categories/categories_controller.dart';

class BrandsController extends AppBaseController<BrandModel> {
  static BrandsController get instance => Get.find<BrandsController>();

  final BrandsRepository _brandsRepository = Get.put(BrandsRepository());
  final CategoriesController _categoriesController = Get.put(CategoriesController());

  @override
  Future<List<BrandModel>> fetchItems() async {
    final brandsList = await _brandsRepository.getAllBrands();
    final brandsCategoriesList = await _brandsRepository.getAllBrandsCategories();
    if (_categoriesController.allItems.isEmpty) await _categoriesController.fetchItems();
    for (var brand in brandsList) {
      final List<String> categoriesIds = brandsCategoriesList
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();
      brand.brandCategories = _categoriesController.allItems
          .where((category) => categoriesIds.contains(category.id))
          .toList();
    }
    return brandsList;
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (category) => category.name.toLowerCase());
  }

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    throw UnauthorizedException();
  }
}
