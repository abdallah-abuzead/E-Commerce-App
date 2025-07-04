import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoaderAnimation extends StatelessWidget {
  const AppLoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppImages.defaultLoaderAnimation, height: 200, width: 200));
  }
}
