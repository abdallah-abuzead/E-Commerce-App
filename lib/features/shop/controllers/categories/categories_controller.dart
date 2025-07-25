import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';
import '../../../../data/repositories/categories/categories_repository.dart';

class CategoriesController extends AppBaseController<CategoryModel> {
  static CategoriesController get instance => Get.find<CategoriesController>();

  final CategoriesRepository _categoryRepository = Get.put(CategoriesRepository());

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (category) => category.name.toLowerCase());
  }

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }
}
