import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Gradient? gradient;
  final DecorationImage? decorationImage;
  final double? radius;
  final Border? border;
  final bool showBorder;
  final List<BoxShadow>? boxShadow;
  final bool showShadow;
  final double? width;
  final double? height;
  final Function()? onTap;

  const AppContainer({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(AppSizes.md),
    this.margin,
    this.alignment,
    this.color,
    this.gradient,
    this.decorationImage,
    this.radius,
    this.border,
    this.showBorder = false,
    this.boxShadow,
    this.showShadow = true,
    this.width,
    this.height,
    this.onTap,
  }) : assert(color == null || gradient == null, 'Cannot provide both color and gradient');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        alignment: alignment ?? Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? AppSizes.cardRadiusLg),
          border: !showBorder ? null : border ?? Border.all(color: AppColors.borderPrimary),
          gradient: gradient,
          image: decorationImage,
          boxShadow: !showShadow
              ? null
              : boxShadow ??
                    [
                      BoxShadow(
                        color: AppColors.grey.withValues(alpha: 0.1),
                        blurRadius: 8,
                        spreadRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
        ),
        child: child,
      ),
    );
  }
}
