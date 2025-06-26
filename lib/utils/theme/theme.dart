import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Urbanist',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.primaryBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(centerTitle: false, backgroundColor: AppColors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primary),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: AppSizes.fontSizeSm, fontWeight: FontWeight.w500),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: AppSizes.fontSizeSm, fontWeight: FontWeight.w500),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.textPrimary),
        side: WidgetStateProperty.all(const BorderSide(color: AppColors.borderPrimary)),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: AppSizes.fontSizeSm, fontWeight: FontWeight.w500),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Urbanist',
        fontSize: AppSizes.fontSizeSm,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),

      labelStyle: const TextStyle(fontSize: AppSizes.fontSizeSm),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.md),
      isDense: true,
    ),
    iconTheme: const IconThemeData(color: AppColors.iconPrimary, size: AppSizes.iconMd),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all(AppSizes.iconMd),
        foregroundColor: WidgetStateProperty.all(AppColors.iconPrimary),
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: AppSizes.fontSizeSm, color: AppColors.textSecondary),
      bodyMedium: TextStyle(fontSize: AppSizes.fontSizeSm, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: AppSizes.fontSizeSm, color: AppColors.textPrimary),
      titleSmall: TextStyle(
        fontSize: AppSizes.fontSizeSm,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: AppSizes.fontSizeSm,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: AppSizes.fontSizeSm,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(fontSize: AppSizes.fontSizeSm, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: AppSizes.fontSizeLg, color: AppColors.textSecondary),
      headlineSmall: TextStyle(
        fontSize: 12,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: AppSizes.fontSizeSm,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        fontSize: AppSizes.fontSizeLg,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Urbanist',
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
  );
}
