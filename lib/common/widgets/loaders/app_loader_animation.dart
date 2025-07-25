import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoaderAnimation extends StatelessWidget {
  const AppLoaderAnimation({super.key, this.width = 300, this.height = 300});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(AppImages.defaultLoaderAnimation, height: height, width: width),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const Text('Loading your data...'),
        ],
      ),
    );
  }
}
