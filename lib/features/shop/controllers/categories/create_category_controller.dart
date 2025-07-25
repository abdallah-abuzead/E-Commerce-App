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

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find<CreateCategoryController>();

  final Rx<CategoryModel> selectedParent = CategoryModel.empty().obs;
  final RxBool loading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> createCategory() async {
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

      // Create a new category
      CategoryModel newRecord = CategoryModel(
        id: '',
        name: nameController.text.trim(),
        image: imageUrl.value,
        parentId: selectedParent.value.id,
        isFeatured: isFeatured.value,
        createdAt: DateTime.now(),
      );
      newRecord.id = await CategoriesRepository.instance.createCategory(newRecord);
      CategoriesController.instance.addItemToLists(newRecord);

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
    selectedParent.value = CategoryModel.empty();
    isFeatured(false);
    loading(false);
  }
}
