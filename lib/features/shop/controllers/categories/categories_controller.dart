import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repository.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find<CategoriesController>();

  RxBool isLoading = true.obs;

  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  Rx<bool> sortAscending = true.obs;

  final searchTextController = TextEditingController();

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

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      final aName = a.name.toLowerCase();
      final bName = b.name.toLowerCase();
      return ascending ? aName.compareTo(bName) : bName.compareTo(aName);
    });
  }

  void sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      final aName = a.name.toLowerCase();
      final bName = b.name.toLowerCase();
      return ascending ? aName.compareTo(bName) : bName.compareTo(aName);
    });
  }

  void searchCategories(String query) {
    filteredItems.assignAll(
      allItems.where((item) => item.name.toLowerCase().contains(query.toLowerCase())),
    );
  }
}
