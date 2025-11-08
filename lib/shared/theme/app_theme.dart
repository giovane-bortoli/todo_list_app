import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/theme/app_colors.dart';
import 'package:todo_list_app/shared/theme/widgets/app_bar_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/button_themes.dart';
import 'package:todo_list_app/shared/theme/widgets/card_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/checkbox_switch_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/chip_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/dialog_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/input_theme.dart';
import 'package:todo_list_app/shared/theme/widgets/other_themes.dart';
import 'package:todo_list_app/shared/theme/widgets/typography_theme.dart';

/// Classe que configura os temas Light e Dark do aplicativo
/// Utiliza Material Design 3 com ColorScheme
///
/// Os temas dos componentes individuais estão organizados em:
/// - lib/shared/theme/widgets/
class AppTheme {
  AppTheme._();

  // ===== LIGHT THEME =====
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onPrimaryLight,
        primaryContainer: AppColors.primaryContainerLight,
        onPrimaryContainer: AppColors.onPrimaryContainerLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.onSecondaryLight,
        secondaryContainer: AppColors.secondaryContainerLight,
        onSecondaryContainer: AppColors.onSecondaryContainerLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.onSurfaceLight,
        surfaceContainerHighest: AppColors.surfaceVariantLight,
        error: AppColors.error,
        onError: AppColors.onError,
        outline: AppColors.outlineLight,
        outlineVariant: AppColors.outlineVariantLight,
        shadow: AppColors.shadowLight,
        scrim: AppColors.scrim,
      ),

      scaffoldBackgroundColor: AppColors.backgroundLight,

      appBarTheme: AppBarThemes.light,
      cardTheme: CardThemes.light,
      elevatedButtonTheme: ButtonThemes.elevatedLight,
      outlinedButtonTheme: ButtonThemes.outlinedLight,
      textButtonTheme: ButtonThemes.textLight,
      floatingActionButtonTheme: ButtonThemes.fabLight,
      inputDecorationTheme: InputThemes.light,
      checkboxTheme: CheckboxSwitchThemes.checkboxLight,
      switchTheme: CheckboxSwitchThemes.switchLight,
      chipTheme: ChipThemes.light,
      dividerTheme: OtherThemes.dividerLight,
      dialogTheme: DialogThemes.dialogLight,
      bottomSheetTheme: DialogThemes.bottomSheetLight,
      snackBarTheme: OtherThemes.snackBarLight,
      iconTheme: OtherThemes.iconLight,
      textTheme: TypographyThemes.light,
    );
  }

  // ===== DARK THEME =====
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        onPrimary: AppColors.onPrimaryDark,
        primaryContainer: AppColors.primaryContainerDark,
        onPrimaryContainer: AppColors.onPrimaryContainerDark,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.onSecondaryDark,
        secondaryContainer: AppColors.secondaryContainerDark,
        onSecondaryContainer: AppColors.onSecondaryContainerDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.onSurfaceDark,
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        error: AppColors.errorLight,
        onError: AppColors.onError,
        outline: AppColors.outlineDark,
        outlineVariant: AppColors.outlineVariantDark,
        shadow: AppColors.shadowDark,
        scrim: AppColors.scrim,
      ),

      scaffoldBackgroundColor: AppColors.backgroundDark,

      appBarTheme: AppBarThemes.dark,
      cardTheme: CardThemes.dark,
      elevatedButtonTheme: ButtonThemes.elevatedDark,
      outlinedButtonTheme: ButtonThemes.outlinedDark,
      textButtonTheme: ButtonThemes.textDark,
      floatingActionButtonTheme: ButtonThemes.fabDark,
      inputDecorationTheme: InputThemes.dark,
      checkboxTheme: CheckboxSwitchThemes.checkboxDark,
      switchTheme: CheckboxSwitchThemes.switchDark,
      chipTheme: ChipThemes.dark,
      dividerTheme: OtherThemes.dividerDark,
      dialogTheme: DialogThemes.dialogDark,
      bottomSheetTheme: DialogThemes.bottomSheetDark,
      snackBarTheme: OtherThemes.snackBarDark,
      iconTheme: OtherThemes.iconDark,
      textTheme: TypographyThemes.dark,
    );
  }
}
