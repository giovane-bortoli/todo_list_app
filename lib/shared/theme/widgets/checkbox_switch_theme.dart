import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';

/// Configurações de tema para Checkbox e Switch
class CheckboxSwitchThemes {
  CheckboxSwitchThemes._();

  // ===== CHECKBOX =====

  /// Checkbox theme para Light Mode
  static CheckboxThemeData get checkboxLight => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return AppColors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.onPrimaryLight),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  /// Checkbox theme para Dark Mode
  static CheckboxThemeData get checkboxDark => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return AppColors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.onPrimaryDark),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  // ===== SWITCH =====

  /// Switch theme para Light Mode
  static SwitchThemeData get switchLight => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return AppColors.outlineLight;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight.withValues(alpha: 0.5);
      }
      return AppColors.outlineLight.withValues(alpha: 0.5);
    }),
  );

  /// Switch theme para Dark Mode
  static SwitchThemeData get switchDark => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return AppColors.outlineDark;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark.withValues(alpha: 0.5);
      }
      return AppColors.outlineDark.withValues(alpha: 0.5);
    }),
  );
}
