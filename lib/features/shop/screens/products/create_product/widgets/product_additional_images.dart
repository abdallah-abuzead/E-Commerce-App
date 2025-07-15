import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    required this.onTapToAddImages,
    required this.onTapToRemoveImages,
  });

  final RxList<String> additionalProductImagesURLs;
  final Function() onTapToAddImages;
  final Function(int) onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
