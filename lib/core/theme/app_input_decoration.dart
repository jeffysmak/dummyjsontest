import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_sizes.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

final class AppInputDecoration {
  const AppInputDecoration._();

  static InputDecorationTheme createTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color fillColor = isDark ? AppColors.darkSurfaceVariant : AppColors.softCream;
    final Color borderColor = isDark ? AppColors.darkBorder : AppColors.creamBorder;
    final Color focusColor = isDark ? AppColors.softSage : AppColors.deepSage;

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm + 4),
      hintStyle: AppTextStyles.hint(brightness: brightness),
      labelStyle: AppTextStyles.input(brightness: brightness, fontSize: 14.0, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: BorderSide(color: borderColor, width: AppSizes.borderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: BorderSide(color: borderColor, width: AppSizes.borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: BorderSide(color: focusColor, width: AppSizes.borderWidthFocused),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.error, width: AppSizes.borderWidth),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.error, width: AppSizes.borderWidthFocused),
      ),
    );
  }
}
