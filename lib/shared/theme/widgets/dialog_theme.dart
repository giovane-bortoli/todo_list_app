import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

/// Configurações de tema para Dialogs e Bottom Sheets
class DialogThemes {
  DialogThemes._();

  // ===== DIALOG =====

  /// Dialog theme para Light Mode
  static DialogThemeData get dialogLight => DialogThemeData(
    backgroundColor: AppColors.surfaceLight,
    elevation: 8,
    shadowColor: AppColors.shadowLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurfaceLight),
    contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceLight),
  );

  /// Dialog theme para Dark Mode
  static DialogThemeData get dialogDark => DialogThemeData(
    backgroundColor: AppColors.surfaceDark,
    elevation: 8,
    shadowColor: AppColors.shadowDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurfaceDark),
    contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceDark),
  );

  // ===== BOTTOM SHEET =====

  /// BottomSheet theme para Light Mode
  static const BottomSheetThemeData bottomSheetLight = BottomSheetThemeData(
    backgroundColor: AppColors.surfaceLight,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
  );

  /// BottomSheet theme para Dark Mode
  static const BottomSheetThemeData bottomSheetDark = BottomSheetThemeData(
    backgroundColor: AppColors.surfaceDark,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
  );
}
