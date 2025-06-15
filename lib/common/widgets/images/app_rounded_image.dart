import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_sizes.dart';
import '../../../utils/constants/enums.dart';
import '../shimmers/app_shimmer_effect.dart';

class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({
    super.key,
    this.image,
    this.file,
    this.border,
    this.width = 56,
    this.height = 56,
    this.memoryImage,
    this.overlayColor,
    this.imageType = ImageType.asset,
    this.backgroundColor,
    this.padding = AppSizes.sm,
    this.margin,
    this.fit = BoxFit.contain,
    this.applyImageRadius = true,
    this.borderRadius = AppSizes.md,
  });

  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final String? image;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: _buildImageWidget(),
      ),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;
    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    return image == null
        ? Container()
        : CachedNetworkImage(
            imageUrl: image!,
            fit: fit,
            color: overlayColor,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                AppShimmerEffect(width: width, height: height),
          );
  }

  Widget _buildMemoryImage() {
    return memoryImage == null
        ? Container()
        : Image(
            image: MemoryImage(memoryImage!),
            fit: fit,
            color: overlayColor,
          );
  }

  Widget _buildFileImage() {
    return file == null
        ? Container()
        : Image(image: FileImage(file!), fit: fit, color: overlayColor);
  }

  Widget _buildAssetImage() {
    return image == null
        ? Container()
        : Image(image: AssetImage(image!), fit: fit, color: overlayColor);
  }
}
