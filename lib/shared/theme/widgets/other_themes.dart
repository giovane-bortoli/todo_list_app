import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

class OtherThemes {
  OtherThemes._();

  static const DividerThemeData dividerLight = DividerThemeData(color: AppColors.outlineLight, thickness: 1, space: 1);

  static const DividerThemeData dividerDark = DividerThemeData(color: AppColors.outlineDark, thickness: 1, space: 1);

  static SnackBarThemeData get snackBarLight => SnackBarThemeData(
    backgroundColor: AppColors.onSurfaceLight,
    contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.surfaceLight),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static SnackBarThemeData get snackBarDark => SnackBarThemeData(
    backgroundColor: AppColors.onSurfaceDark,
    contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.surfaceDark),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static const IconThemeData iconLight = IconThemeData(color: AppColors.onSurfaceLight, size: 24);

  static const IconThemeData iconDark = IconThemeData(color: AppColors.onSurfaceDark, size: 24);
}
