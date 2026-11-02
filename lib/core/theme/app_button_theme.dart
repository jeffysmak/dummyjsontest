import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_sizes.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

final class AppButtonTheme {
  const AppButtonTheme._();

  static ElevatedButtonThemeData createElevatedButtonTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color backgroundColor = isDark ? AppColors.softSage : AppColors.deepSage;
    final Color foregroundColor = isDark ? AppColors.deepCharcoal : Colors.white;

    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
        textStyle: AppTextStyles.button(brightness: brightness, fontSize: 15.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  static OutlinedButtonThemeData createOutlinedButtonTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color borderColor = isDark ? AppColors.softSage : AppColors.deepSage;
    final Color foregroundColor = isDark ? AppColors.softSage : AppColors.deepSage;

    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        side: BorderSide(color: borderColor, width: AppSizes.borderWidthFocused),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
        textStyle: AppTextStyles.button(brightness: brightness, fontSize: 15.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  static TextButtonThemeData createTextButtonTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color foregroundColor = isDark ? AppColors.softSage : AppColors.deepSage;

    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        minimumSize: const Size(0, AppSizes.buttonHeightSm),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderSm),
        textStyle: AppTextStyles.button(brightness: brightness, fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
