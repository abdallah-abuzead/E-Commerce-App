import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/app_animation_loader_widget.dart';
import '../../common/widgets/loaders/circular_loader.dart';
import '../helpers/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Container(
            color: HelperFunctions.isDarkMode(Get.context!) ? AppColors.dark : AppColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 250),
                AppAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        );
      },
    );
  }

  static void popUpCircular() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const CircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  static void stopLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
