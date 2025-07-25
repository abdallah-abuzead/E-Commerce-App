import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/app_sizes.dart';
import '../../utils/popups/app_loaders.dart';
import '../../utils/popups/full_screen_loader.dart';

abstract class AppBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  Rx<bool> sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// abstract method to be implemented by subclasses to fetch the items from the database
  Future<List<T>> fetchItems();

  /// abstract method to be implemented by subclasses to delete the item from the database
  Future<void> deleteItem(T item);

  /// abstract method to be implemented by subclasses to check if the item contains the search query
  bool containsSearchQuery(T item, String query);

  /// common method for fetching data from the database and update the lists
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) fetchedItems = await fetchItems();
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.filled(allItems.length, false));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// common method for searching based on the search query
  void searchQuery(String query) {
    filteredItems.assignAll(allItems.where((item) => containsSearchQuery(item, query)));
  }

  /// common method for sorting the items based on the column index and ascending order
  void sortByProperty(int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      return ascending ? property(a).compareTo(property(b)) : property(b).compareTo(property(a));
    });
  }

  /// common method for adding an item to the lists
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.filled(allItems.length, false));
  }

  /// common method for updating an item in the lists
  void updateItemInLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);
    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;
  }

  /// common method for deleting an item from the lists
  void removeItemFromLists(T category) {
    allItems.remove(category);
    filteredItems.remove(category);
    selectedRows.assignAll(List.filled(allItems.length, false));
  }

  /// common method for confirming deletion and performing the deletion of an item
  void confirmAndDeleteItem(T category) {
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

  /// common method for deleting an item after confirmation
  Future<void> deleteOnConfirm(T item) async {
    try {
      // Remove the confirmation dialog
      FullScreenLoader.stopLoadingDialog();

      // Start the loader
      FullScreenLoader.popUpCircular();

      // Delete Firestore data
      await deleteItem(item);

      // Remove the item from the list
      removeItemFromLists(item);

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
}
