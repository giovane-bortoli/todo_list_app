import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge =>
      TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w700, height: 1.12, letterSpacing: -0.25);

  static TextStyle get displayMedium => TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w700, height: 1.16);

  static TextStyle get displaySmall => TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w700, height: 1.22);

  static TextStyle get headlineLarge => TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700, height: 1.25);

  static TextStyle get headlineMedium => TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.29);

  static TextStyle get headlineSmall => TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, height: 1.33);

  static TextStyle get titleLarge => TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, height: 1.27);

  static TextStyle get titleMedium =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.5, letterSpacing: 0.15);

  static TextStyle get titleSmall =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.43, letterSpacing: 0.1);

  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.5);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.43, letterSpacing: 0.25);

  static TextStyle get bodySmall =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.33, letterSpacing: 0.4);

  static TextStyle get labelLarge =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.43, letterSpacing: 0.1);

  static TextStyle get labelMedium =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.33, letterSpacing: 0.5);

  static TextStyle get labelSmall =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, height: 1.45, letterSpacing: 0.5);

  static TextStyle get taskTitle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.5, letterSpacing: 0.15);

  static TextStyle get taskDescription =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.25);

  static TextStyle get taskDateTime =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.33, letterSpacing: 0.4);

  static TextStyle get statusBadge =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, height: 1.45, letterSpacing: 0.5);

  static TextStyle get taskCategory =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.33, letterSpacing: 0.5);

  static TextStyle get taskCompleted => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.grey,
    color: Colors.grey,
  );

  static TextStyle get appBarTitle => TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get buttonLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: 0.5);

  static TextStyle get buttonMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, height: 1.43, letterSpacing: 0.5);

  static TextStyle get inputPlaceholder =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.25);

  static TextStyle get inputLabel =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.33, letterSpacing: 0.4);

  static TextStyle get errorText =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.33, letterSpacing: 0.4);

  static TextStyle get hintText => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    fontStyle: FontStyle.italic,
  );
}
