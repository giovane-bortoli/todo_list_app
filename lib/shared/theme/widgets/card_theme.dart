import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';

/// Configurações de tema para Card
class CardThemes {
  CardThemes._();

  /// Card theme para Light Mode
  static CardThemeData get light => CardThemeData(
    elevation: 2,
    color: AppColors.surfaceLight,
    surfaceTintColor: AppColors.transparent,
    shadowColor: AppColors.shadowLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  /// Card theme para Dark Mode
  static CardThemeData get dark => CardThemeData(
    elevation: 2,
    color: AppColors.surfaceDark,
    surfaceTintColor: AppColors.transparent,
    shadowColor: AppColors.shadowDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
}
