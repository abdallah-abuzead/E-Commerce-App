import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/routes/app_screens.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners_repository/banners_repository.dart';
import '../../../../utils/popups/app_loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../media/models/image_model.dart';
import '../../models/banner_model.dart';
import 'banners_controller.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find<CreateBannerController>();

  final RxBool loading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> createBanner() async {
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

      // Create a new banner
      final BannerModel newRecord = BannerModel(
        imageUrl: imageUrl.value,
        active: isActive.value,
        targetScreen: targetScreen.value,
      );
      newRecord.id = await BannersRepository.instance.createBanner(newRecord);
      BannersController.instance.addItemToLists(newRecord);

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
    imageUrl.value = '';
    targetScreen.value = AppScreens.allAppScreenItems[0];
    isActive(false);
    loading(false);
  }
}
