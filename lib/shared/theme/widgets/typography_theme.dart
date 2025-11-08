import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

class TypographyThemes {
  TypographyThemes._();

  static TextTheme get light => TextTheme(
    displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.onBackgroundLight),
    displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.onBackgroundLight),
    displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.onBackgroundLight),
    headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.onBackgroundLight),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.onBackgroundLight),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.onBackgroundLight),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurfaceLight),
    titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurfaceLight),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurfaceLight),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.onBackgroundLight),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.onBackgroundLight),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.onBackgroundLight),
    labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurfaceLight),
    labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceLight),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceLight),
  );

  static TextTheme get dark => TextTheme(
    displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.onBackgroundDark),
    displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.onBackgroundDark),
    displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.onBackgroundDark),
    headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.onBackgroundDark),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.onBackgroundDark),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.onBackgroundDark),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurfaceDark),
    titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurfaceDark),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurfaceDark),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.onBackgroundDark),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.onBackgroundDark),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.onBackgroundDark),
    labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurfaceDark),
    labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceDark),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceDark),
  );
}
