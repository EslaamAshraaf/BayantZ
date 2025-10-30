import 'package:flutter/material.dart';
import 'App_Colors.dart';

/// Purpose: Defines all text styles used across the BayanatZ app.
/// Font: Cairo

class AppTextStyles {
  /// Title — SemiBold, 28px
  static TextStyle title(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 1.0,
      letterSpacing: 0,
      color: isDark ? AppColors.textPrimary : AppColors.textPrimary,
    );
  }

  /// Subtitle — Medium, 18px
  static TextStyle subtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.0,
      letterSpacing: -0.82,
      color: isDark ? Colors.white : AppColors.textPrimary,
    );
  }

  /// Body — Medium, 16px
  static TextStyle body(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.0,
      letterSpacing: -0.82,
      color: isDark ? Colors.grey[300] : AppColors.textSecondary,
    );
  }

  /// Table Text — Regular, 12px
  static TextStyle table(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.0,
      letterSpacing: 0,
      color: isDark ? Colors.white : AppColors.textPrimary,
    );
  }
}
