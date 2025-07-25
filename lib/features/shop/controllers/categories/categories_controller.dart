import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repository.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find<CategoriesController>();

  RxBool isLoading = true.obs;

  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

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
      selectedRows.assignAll(List.filled(allItems.length, false));
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

  void confirmAndDeleteItem(CategoryModel category) {
    // Show confirmation dialog before deleting
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(category),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Ok'),
        ),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<void> deleteOnConfirm(CategoryModel category) async {
    try {
      // Remove the confirmation dialog
      FullScreenLoader.stopLoadingDialog();

      // Start the loader
      FullScreenLoader.popUpCircular();

      // Delete Firestore data
      await _categoryRepository.deleteCategory(category.id);

      // Remove the item from the list
      removeItemFromLists(category);

      // Stop the loader
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.successSnackBar(
        title: 'Item Deleted',
        message: 'Your item has been deleted successfully',
      );
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void removeItemFromLists(CategoryModel category) {
    allItems.remove(category);
    filteredItems.remove(category);
    selectedRows.assignAll(List.filled(allItems.length, false));
  }

  void addItemToLists(CategoryModel item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.filled(allItems.length, false));
    allItems.refresh();
  }
}
