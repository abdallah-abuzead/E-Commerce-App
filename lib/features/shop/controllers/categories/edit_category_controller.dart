import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/categories/categories_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repository.dart';
import '../../../../utils/popups/app_loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../media/models/image_model.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find<EditCategoryController>();

  final Rx<CategoryModel> selectedParent = CategoryModel.empty().obs;
  final RxBool loading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Init Data
  void init(CategoryModel category) {
    nameController.text = category.name;
    isFeatured.value = category.isFeatured;
    imageUrl.value = category.image;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoriesController.instance.allItems
          .where((item) => item.id == category.parentId)
          .single;
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      // Start loading
      FullScreenLoader.popUpCircular();

      // Check Internet connection
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update category
      category.name = nameController.text.trim();
      category.image = imageUrl.value;
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();
      await CategoriesRepository.instance.updateCategory(category);
      CategoriesController.instance.updateItemInLists(category);

      // Reset fields
      resetFields();

      // Stop the loader
      FullScreenLoader.stopLoading();
      AppLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Item has been updated successfully',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> pickImage() async {
    final MediaController mediaController = Get.put(MediaController());
    final List<ImageModel>? selectedImages = await mediaController.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      imageUrl.value = selectedImages.first.url;
    }
  }

  void resetFields() {
    nameController.clear();
    imageUrl.value = '';
    selectedParent.value = CategoryModel.empty();
    isFeatured(false);
    loading(false);
  }
}
