import 'package:clipboard/clipboard.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageDetailsPopup extends StatelessWidget {
  final ImageModel image;

  const ImageDetailsPopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
        child: AppContainer(
          width: DeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    AppContainer(
                      color: AppColors.primaryBackgroundColor,
                      child: AppRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: DeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Text('Image Name: ', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(image.fileName, style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Image URL: ', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(
                          image.url,
                        ).then((value) => AppLoaders.customToast(message: 'URL copied!'));
                      },
                      child: const Text('Copy URL'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () => MediaController.instance.removeCloudImageConfirmation(image),
                      child: const Text('Delete Image', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
