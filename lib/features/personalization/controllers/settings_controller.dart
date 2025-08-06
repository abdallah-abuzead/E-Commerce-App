import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/settings/settings_repository.dart';
import '../models/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find<SettingsController>();

  // Observable variables
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  // Dependencies
  final SettingsRepository settingsRepository = Get.put(SettingsRepository());

  @override
  Future<void> onInit() async {
    // Fetch settings data on controller initialization
    await fetchSettingsDetails();
    super.onInit();
  }

  /// Fetch settings details from repository
  Future<SettingsModel> fetchSettingsDetails() async {
    try {
      loading.value = true;
      final settings = await settingsRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text = settings.freeShippingThreshold?.toString() ?? '';

      return settings;
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return SettingsModel.empty();
    } finally {
      loading.value = false;
    }
  }

  /// Get Thumbnail image from media
  Future<void> updateAppLogo() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      final List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        final ImageModel selectedImage = selectedImages.first;
        await settingsRepository.updateSingleField({'appLogo': selectedImage.url});

        settings.value.appLogo = selectedImage.url;
        settings.refresh();
        AppLoaders.successSnackBar(title: 'Congratulations', message: 'App Logo has been updated.');
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// update settings
  Future<void> updateSettingsInformation() async {
    try {
      loading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxController.text.trim()) ?? 0;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim()) ?? 0;
      settings.value.freeShippingThreshold =
          double.tryParse(freeShippingThresholdController.text.trim()) ?? 0;
      await settingsRepository.updateSettingsDetails(settings.value);

      settings.refresh();
      AppLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'App Settings has been updated.',
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
