import 'dart:typed_data';

import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_dialogs.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../data/repositories/media/media_repository.dart';
import '../../../utils/constants/app_strings.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find<MediaController>();

  final RxBool loading = false.obs;
  int initialLoadCount = 20;
  int loadMoreCount = 25;

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> getMediaImages() async {
    try {
      loading.value = true;
      final RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners && allBannerImages.isEmpty) {
        targetList.value = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products && allProductImages.isEmpty) {
        targetList.value = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands && allBrandImages.isEmpty) {
        targetList.value = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories && allCategoryImages.isEmpty) {
        targetList.value = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users && allUserImages.isEmpty) {
        targetList.value = allUserImages;
      }
      final images = await mediaRepository.fitchImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
      );
      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Unable to fetch Images, Something went wrong, Try again',
      );
    }
  }

  Future<void> loadMoreMediaImages() async {
    try {
      loading.value = true;
      final RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners) {
        targetList.value = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList.value = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList.value = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList.value = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList.value = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
        selectedPath.value,
        loadMoreCount,
        targetList.last.createdAt ?? DateTime.now(),
      );
      targetList.addAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Unable to fetch Images, Something went wrong, Try again',
      );
    }
  }

  Future<void> selectLocalImages() async {
    final List<DropzoneFileInterface> files = await dropzoneController.pickFiles(
      multiple: true,
      mime: const ['image/jpeg', 'image/png'],
    );
    if (files.isNotEmpty) {
      for (final file in files) {
        final Uint8List bytes = await dropzoneController.getFileData(file);
        final ImageModel image = ImageModel(
          url: '',
          folder: '',
          file: file,
          fileName: file.name,
          localeImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      AppLoaders.warningSnackBar(
        title: 'Select Folder',
        message: 'Please select the Folder in order to upload images.',
      );
      return;
    }
    AppDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      cancelText: 'Cancel',
      onConfirm: () async {
        Get.back();
        await uploadImagesToAppwrite();
        // await uploadImages();
      },
      content:
          'Are you sure you want to upload all the images in ${selectedPath.value.name.toUpperCase()} folder?',
    );
  }

  Future<void> uploadImagesToAppwrite() async {
    try {
      uploadImagesDialog();
      final MediaCategory selectedCategory = selectedPath.value;
      final RxList<ImageModel> targetList = <ImageModel>[].obs;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList.value = allBannerImages;
          break;
        case MediaCategory.products:
          targetList.value = allProductImages;
          break;
        case MediaCategory.brands:
          targetList.value = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList.value = allCategoryImages;
          break;
        case MediaCategory.users:
          targetList.value = allUserImages;
          break;
        default:
          return;
      }

      // Using the reverse loop avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        final ImageModel selectedImage = selectedImagesToUpload[i];
        final List<int> imageBytes = selectedImage.localeImageToDisplay!.toList();

        // Upload image to Appwrite Storage
        final ImageModel uploadedImage = await mediaRepository.uploadImageFileInAppwrite(
          fileBytes: imageBytes,
          folder: getSelectedPath(),
          imageName: selectedImage.fileName,
        );

        // Upload image metadata to the database
        uploadedImage.mediaCategory = selectedCategory.name;
        final String id = await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }
      FullScreenLoader.stopLoadingDialog();
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.warningSnackBar(
        title: 'Error Uploading Images',
        message: 'Something went wrong while uploading your images.',
      );
    }
  }

  Future<void> uploadImages() async {
    try {
      uploadImagesDialog();
      final MediaCategory selectedCategory = selectedPath.value;
      final RxList<ImageModel> targetList = <ImageModel>[].obs;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList.value = allBannerImages;
          break;
        case MediaCategory.products:
          targetList.value = allProductImages;
          break;
        case MediaCategory.brands:
          targetList.value = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList.value = allCategoryImages;
          break;
        case MediaCategory.users:
          targetList.value = allUserImages;
          break;
        default:
          return;
      }

      // Using the reverse loop avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        final ImageModel selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file;

        // Upload image to the storage
        final ImageModel uploadedImage = await mediaRepository.uploadImageFileInStorage(
          file: image,
          path: getSelectedPath(),
          imageName: selectedImage.fileName,
        );
        // Upload image metadata to the database
        uploadedImage.mediaCategory = selectedCategory.name;
        final String id = await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }
      FullScreenLoader.stopLoadingDialog();
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.warningSnackBar(
        title: 'Error Uploading Images',
        message: 'Something went wrong while uploading your images.',
      );
    }
  }

  Future<void> uploadImagesDialog() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Uploading Images'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.uploadImageIllustration, width: 300, height: 300),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const Text('Sit Tight, Your images are uploading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = AppStrings.bannersStoragePath;
        break;
      case MediaCategory.products:
        path = AppStrings.productsStoragePath;
        break;
      case MediaCategory.brands:
        path = AppStrings.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = AppStrings.categoriesStoragePath;
        break;
      case MediaCategory.users:
        path = AppStrings.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }
}
