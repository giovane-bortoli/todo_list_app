import 'package:flutter/material.dart';

/// Classe que define todas as cores do aplicativo
/// Utiliza cores semânticas para facilitar manutenção e consistência
class AppColors {
  AppColors._();

  // ===== LIGHT THEME COLORS =====

  /// Cores primárias - Light Mode
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFFE0E7FF);
  static const Color onPrimaryContainerLight = Color(0xFF1E1B4B);

  /// Cores secundárias - Light Mode
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryContainerLight = Color(0xFFF3E8FF);
  static const Color onSecondaryContainerLight = Color(0xFF4C1D95);

  /// Cores de superfície - Light Mode
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF3F4F6);
  static const Color onBackgroundLight = Color(0xFF1F2937);
  static const Color onSurfaceLight = Color(0xFF1F2937);

  /// Cores de borda e divisores - Light Mode
  static const Color outlineLight = Color(0xFFE5E7EB);
  static const Color outlineVariantLight = Color(0xFFF3F4F6);

  // ===== DARK THEME COLORS =====

  /// Cores primárias - Dark Mode
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color onPrimaryDark = Color(0xFF1E1B4B);
  static const Color primaryContainerDark = Color(0xFF3730A3);
  static const Color onPrimaryContainerDark = Color(0xFFE0E7FF);

  /// Cores secundárias - Dark Mode
  static const Color secondaryDark = Color(0xFFA78BFA);
  static const Color onSecondaryDark = Color(0xFF4C1D95);
  static const Color secondaryContainerDark = Color(0xFF6D28D9);
  static const Color onSecondaryContainerDark = Color(0xFFF3E8FF);

  /// Cores de superfície - Dark Mode
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color surfaceVariantDark = Color(0xFF374151);
  static const Color onBackgroundDark = Color(0xFFF9FAFB);
  static const Color onSurfaceDark = Color(0xFFF9FAFB);

  /// Cores de borda e divisores - Dark Mode
  static const Color outlineDark = Color(0xFF4B5563);
  static const Color outlineVariantDark = Color(0xFF374151);

  // ===== CORES SEMÂNTICAS (compartilhadas entre temas) =====

  /// Cores de status para tarefas
  static const Color success = Color(0xFF10B981);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successLight = Color(0xFF34D399);

  static const Color warning = Color(0xFFF59E0B);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningLight = Color(0xFFFBBF24);

  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFF87171);

  static const Color info = Color(0xFF3B82F6);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoLight = Color(0xFF60A5FA);

  /// Cores adicionais para UI
  static const Color pending = Color(0xFF94A3B8);
  static const Color completed = success;
  static const Color overdue = error;

  // ===== CORES DE SOMBRA =====
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);

  // ===== CORES TRANSPARENTES =====
  static const Color transparent = Colors.transparent;
  static const Color scrim = Color(0x99000000);
}
