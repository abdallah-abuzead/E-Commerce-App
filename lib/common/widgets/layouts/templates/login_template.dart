import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_sizes.dart';
import '../../../../utils/constants/app_spacing_styles.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: AppSpacingStyles.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
