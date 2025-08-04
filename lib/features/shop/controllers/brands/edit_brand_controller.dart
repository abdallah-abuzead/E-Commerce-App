import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brands/brands_controller.dart';
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

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find<EditBrandController>();

  final RxBool loading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  final BrandsRepository repository = BrandsRepository.instance;

  /// Init data
  void init(BrandModel brand) {
    nameController.text = brand.name;
    imageUrl.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.assignAll(brand.brandCategories ?? []);
    }
  }

  /// Toggle category selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
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

  Future<void> updateBrand(BrandModel brand) async {
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

      // is brand updated
      bool isBrandUpdated = false;
      if (brand.image != imageUrl.value ||
          brand.name != nameController.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // update record
        brand.name = nameController.text.trim();
        brand.image = imageUrl.value;
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        await repository.updateBrand(brand);
      }

      // Update Brand Categories if any categories are selected
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update brand data in products
      if (isBrandUpdated) await updateBrandInProducts(brand);

      BrandsController.instance.updateItemInLists(brand);

      // Reset fields
      resetFields();

      // Stop the loader
      FullScreenLoader.stopLoading();
      AppLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Record has been updated successfully',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> updateBrandCategories(BrandModel brand) async {
    // Fetch all brand categories
    final List<BrandCategoryModel> brandCategories = await repository.getCategoriesOfSpecificBrand(
      brand.id,
    );

    // Selected categories IDs
    final List<String> selectedCategoriesIds = selectedCategories.map((c) => c.id).toList();

    // Identify categories to be removed
    final List<BrandCategoryModel> categoriesToRemove = brandCategories
        .where((bc) => !selectedCategoriesIds.contains(bc.categoryId))
        .toList();

    // Remove unselected categories
    for (var category in categoriesToRemove) {
      await repository.deleteBrandCategory(category.id!);
    }

    // Identify categories to be added
    final List<CategoryModel> categoriesToAdd = selectedCategories
        .where((c) => !brandCategories.any((bc) => bc.categoryId == c.id))
        .toList();

    // Add new categories
    for (var category in categoriesToAdd) {
      final BrandCategoryModel brandCategory = BrandCategoryModel(
        brandId: brand.id,
        categoryId: category.id,
      );
      brandCategory.id = await repository.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandsController.instance.updateItemInLists(brand);
  }

  Future<void> updateBrandInProducts(BrandModel brand) async {}
}
