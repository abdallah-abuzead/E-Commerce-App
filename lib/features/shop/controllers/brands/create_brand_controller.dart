import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brands/brands_repository.dart';
import '../../../../utils/popups/app_loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import 'brands_controller.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find<CreateBrandController>();

  final RxBool loading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle category selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  Future<void> createBrand() async {
    try {
      // Start loading
      FullScreenLoader.popUpCircular();

      // Check Internet connection
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // Create a new record
      final BrandModel newRecord = BrandModel(
        id: '',
        name: nameController.text.trim(),
        image: imageUrl.value,
        isFeatured: isFeatured.value,
        productsCount: 0,
        createdAt: DateTime.now(),
      );
      newRecord.id = await BrandsRepository.instance.createBrand(newRecord);

      // Register brand categories if any categories are selected
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing relational data. Try again';

        for (var category in selectedCategories) {
          final BrandCategoryModel brandCategory = BrandCategoryModel(
            brandId: newRecord.id,
            categoryId: category.id,
          );
          brandCategory.id = await BrandsRepository.instance.createBrandCategory(brandCategory);
        }
        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update the brands list in BrandsController
      BrandsController.instance.addItemToLists(newRecord);

      // Reset fields
      resetFields();

      // Stop the loader
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'New Record has been added successfully',
      );
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
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
    selectedCategories.clear();
    isFeatured(false);
    loading(false);
  }
}
