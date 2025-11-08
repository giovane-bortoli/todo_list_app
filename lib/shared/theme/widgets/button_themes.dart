import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

/// Configurações de tema para todos os tipos de botões
class ButtonThemes {
  ButtonThemes._();

  // ===== ELEVATED BUTTON =====

  /// ElevatedButton theme para Light Mode
  static ElevatedButtonThemeData get elevatedLight => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.onPrimaryLight,
      elevation: 2,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  /// ElevatedButton theme para Dark Mode
  static ElevatedButtonThemeData get elevatedDark => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.onPrimaryDark,
      elevation: 2,
      shadowColor: AppColors.shadowDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  // ===== OUTLINED BUTTON =====

  /// OutlinedButton theme para Light Mode
  static OutlinedButtonThemeData get outlinedLight => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      side: const BorderSide(color: AppColors.primaryLight, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  /// OutlinedButton theme para Dark Mode
  static OutlinedButtonThemeData get outlinedDark => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
      side: const BorderSide(color: AppColors.primaryDark, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  // ===== TEXT BUTTON =====

  /// TextButton theme para Light Mode
  static TextButtonThemeData get textLight => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  /// TextButton theme para Dark Mode
  static TextButtonThemeData get textDark => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: AppTextStyles.buttonMedium,
    ),
  );

  // ===== FLOATING ACTION BUTTON =====

  /// FloatingActionButton theme para Light Mode
  static const FloatingActionButtonThemeData fabLight = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryLight,
    foregroundColor: AppColors.onPrimaryLight,
    elevation: 4,
    shape: CircleBorder(),
  );

  /// FloatingActionButton theme para Dark Mode
  static const FloatingActionButtonThemeData fabDark = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: AppColors.onPrimaryDark,
    elevation: 4,
    shape: CircleBorder(),
  );
}
