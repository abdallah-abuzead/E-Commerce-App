import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Gradient? gradient;
  final DecorationImage? decorationImage;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;

  const AppContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.gradient,
    this.decorationImage,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
  }) : assert(
         color == null || gradient == null,
         'Cannot provide both color and gradient',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: border,
        gradient: gradient,
        image: decorationImage,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
