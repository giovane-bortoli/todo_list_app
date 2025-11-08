import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

/// Configurações de tema para AppBar
class AppBarThemes {
  AppBarThemes._();

  /// AppBar theme para Light Mode
  static AppBarTheme get light => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppColors.surfaceLight,
    foregroundColor: AppColors.onSurfaceLight,
    surfaceTintColor: AppColors.transparent,
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.onSurfaceLight),
    iconTheme: const IconThemeData(color: AppColors.onSurfaceLight),
  );

  /// AppBar theme para Dark Mode
  static AppBarTheme get dark => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.onSurfaceDark,
    surfaceTintColor: AppColors.transparent,
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(color: AppColors.onSurfaceDark),
    iconTheme: const IconThemeData(color: AppColors.onSurfaceDark),
  );
}
