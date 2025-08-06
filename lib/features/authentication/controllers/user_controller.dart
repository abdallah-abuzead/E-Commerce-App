import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../media/controllers/media_controller.dart';
import '../../media/models/image_model.dart';
import '../../personalization/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find<UserController>();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final UserRepository userRepository = Get.put(UserRepository());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  onInit() async {
    await fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final UserModel user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      AppLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return UserModel.empty();
    }
  }

  /// Get Thumbnail image from media
  Future<void> updateProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      final List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        final ImageModel selectedImage = selectedImages.first;
        await userRepository.updateSingleField({'profilePicture': selectedImage.url});

        user.value.profilePicture = selectedImage.url;
        user.refresh();
        AppLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'User Profile Picture has been updated.',
        );
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// update user data
  Future<void> updateUserInformation() async {
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

      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();
      await userRepository.updateUserDetails(user.value);

      user.refresh();
      AppLoaders.successSnackBar(title: 'Congratulations', message: 'user data has been updated.');
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
