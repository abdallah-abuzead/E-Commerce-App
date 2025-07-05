import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({
    super.key,
    this.foregroundColor = Colors.white,
    this.backgroundColor = AppColors.primary,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(
          color: foregroundColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
