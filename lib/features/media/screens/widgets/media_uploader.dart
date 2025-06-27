import 'dart:io';
import 'dart:typed_data';

import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_folder_dropdown.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../utils/constants/app_images.dart';
import '../../controllers/media_controller.dart';
import '../../models/image_model.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaController controller = MediaController.instance;
    return Column(
      children: [
        /// Drag and drop area
        AppContainer(
          showBorder: true,
          height: 250,
          color: AppColors.primaryBackgroundColor,
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DropzoneView(
                      mime: const ['image/jpeg', 'image/png'],
                      cursor: CursorType.Default,
                      operation: DragOperation.copy,
                      onLoaded: () => print('Zone loaded'),
                      onError: (String? ev) => print('Zone error: $ev'),
                      onHover: () => print('Zone hover'),
                      onLeave: () => print('Zone left'),
                      onCreated: (ctrl) => controller.dropzoneController = ctrl,
                      onDropInvalid: (ev) => print('Zone Invalid Mime: $ev'),
                      onDropFiles: (files) => print('Zone drop multiple files: $files'),
                      onDropFile: (file) async {
                        if (file is html.File) {
                          final Uint8List bytes = await controller.dropzoneController.getFileData(
                            file,
                          );
                          final ImageModel image = ImageModel(
                            url: '',
                            file: file as File,
                            folder: '',
                            fileName: file.name,
                            localeImageToDisplay: Uint8List.fromList(bytes),
                          );
                        }
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImages.defaultMultipleImageIcon, width: 50, height: 50),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        const Text('Drag and Drop Images here'),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        OutlinedButton(onPressed: () {}, child: const Text('Select Images')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        /// Locally selected images
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Folder Dropdown
                  Row(
                    children: [
                      Text('Selected Folder', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      MediaFolderDropdown(
                        onChanged: (newValue) {
                          if (newValue != null) controller.selectedPath.value = newValue;
                        },
                      ),
                    ],
                  ),

                  /// Upload and Remove buttons
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Remove All')),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      DeviceUtils.isMobileScreen(context)
                          ? const SizedBox.shrink()
                          : SizedBox(
                              width: AppSizes.buttonWidth,
                              child: ElevatedButton(onPressed: () {}, child: const Text('Upload')),
                            ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Wrap(
                alignment: WrapAlignment.start,
                spacing: AppSizes.spaceBtwItems / 2,
                runSpacing: AppSizes.spaceBtwItems / 2,
                children: List.generate(
                  10,
                  (index) => const AppRoundedImage(
                    width: 90,
                    height: 90,
                    padding: AppSizes.sm,
                    imageType: ImageType.asset,
                    image: AppImages.user,
                    backgroundColor: AppColors.primaryBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              DeviceUtils.isMobileScreen(context)
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () {}, child: const Text('Upload')),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
