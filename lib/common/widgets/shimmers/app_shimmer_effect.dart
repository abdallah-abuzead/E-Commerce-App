import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/app_colors.dart';

class AppShimmerEffect extends StatelessWidget {
  const AppShimmerEffect({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppColors.softGrey,
        highlightColor: AppColors.lightGrey,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.softGrey,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
    ;
  }
}
