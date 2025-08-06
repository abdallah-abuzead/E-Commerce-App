import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_circular_image.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../icons/app_circular_icon.dart';

class AppImageUploader extends StatelessWidget {
  const AppImageUploader({
    super.key,
    this.image,
    this.onIconButtonPressed,
    this.memoryImage,
    this.width = 100,
    this.height = 100,
    required this.imageType,
    this.circular = false,
    this.icon = Iconsax.edit_2,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
    this.loading = false,
  });

  /// Whether to display loading instead of icon
  final bool loading;

  /// Whether to display the image in the circular shape
  final bool circular;

  /// URL or path to display the image
  final String? image;

  final ImageType imageType;

  final double width;
  final double height;

  final Uint8List? memoryImage;

  final IconData icon;

  /// offset from the top edge of the widget
  final double? top;

  /// offset from the bottom edge of the widget
  final double? bottom;

  /// offset from the right edge of the widget
  final double? right;

  /// offset from the left edge of the widget
  final double? left;

  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        circular
            ? AppCircularImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: AppColors.primaryBackground,
              )
            : AppRoundedImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: AppColors.primaryBackground,
              ),
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: loading
              ? const AppContainer(
                  width: AppSizes.xl,
                  height: AppSizes.xl,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: AppColors.primary,
                    color: Colors.white,
                  ),
                )
              : AppCircularIcon(
                  icon: icon,
                  size: AppSizes.md,
                  color: Colors.white,
                  onPressed: onIconButtonPressed,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.9),
                ),
        ),
      ],
    );
  }
}
