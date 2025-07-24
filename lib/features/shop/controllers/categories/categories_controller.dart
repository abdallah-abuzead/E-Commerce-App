import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repository.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find<CategoriesController>();

  RxBool isLoading = true.obs;

  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  final CategoriesRepository _categoryRepository = Get.put(CategoriesRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _categoryRepository.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
