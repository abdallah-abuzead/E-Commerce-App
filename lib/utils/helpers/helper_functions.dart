import 'package:flutter/material.dart';

abstract class HelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static String getErrorMessage(String? error) {
    return error?.isEmpty ?? true ? 'An unknown error occurred.' : error!;
  }

  static String? getString(String? value) {
    return value?.isEmpty ?? true ? null : value;
  }

  static int? getInt(int? value) {
    return value == null || value <= 0 ? null : value;
  }

  static double? getDouble(double? value) {
    return value == null || value <= 0 ? null : value;
  }
}
