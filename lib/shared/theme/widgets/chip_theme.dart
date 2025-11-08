import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

/// Configurações de tema para Chips
class ChipThemes {
  ChipThemes._();

  /// Chip theme para Light Mode
  static ChipThemeData get light => ChipThemeData(
    backgroundColor: AppColors.surfaceVariantLight,
    selectedColor: AppColors.primaryContainerLight,
    labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceLight),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  /// Chip theme para Dark Mode
  static ChipThemeData get dark => ChipThemeData(
    backgroundColor: AppColors.surfaceVariantDark,
    selectedColor: AppColors.primaryContainerDark,
    labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceDark),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
