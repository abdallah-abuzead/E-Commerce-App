import 'package:flutter/material.dart';

class AppCircularIcon extends StatelessWidget {
  const AppCircularIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final IconData icon;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(backgroundColor)),
      icon: Icon(icon, size: size, color: color),
    );
  }
}
