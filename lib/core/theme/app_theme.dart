import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_colors.dart';
import 'app_input_decoration.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.deepSage,
      onPrimary: Colors.white,
      primaryContainer: AppColors.sageLightContainer,
      onPrimaryContainer: AppColors.deepSage,
      secondary: AppColors.peachDark,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.peachLightContainer,
      onSecondaryContainer: AppColors.peachDark,
      tertiary: AppColors.softSage,
      onTertiary: AppColors.deepCharcoal,
      tertiaryContainer: AppColors.sageLightContainer,
      onTertiaryContainer: AppColors.deepSage,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.error,
      surface: AppColors.warmIvory,
      onSurface: AppColors.deepCharcoal,
      surfaceContainerHighest: AppColors.softCream,
      onSurfaceVariant: AppColors.charcoalMuted,
      outline: AppColors.creamBorder,
      outlineVariant: AppColors.creamBorder,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: AppColors.deepCharcoal,
      onInverseSurface: AppColors.warmIvory,
      inversePrimary: AppColors.softSage,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.warmIvory,
      textTheme: AppTextStyles.createTextTheme(Brightness.light),
      inputDecorationTheme: AppInputDecoration.createTheme(Brightness.light),
      elevatedButtonTheme: AppButtonTheme.createElevatedButtonTheme(Brightness.light),
      outlinedButtonTheme: AppButtonTheme.createOutlinedButtonTheme(Brightness.light),
      textButtonTheme: AppButtonTheme.createTextButtonTheme(Brightness.light),
      cardTheme: CardThemeData(
        color: AppColors.softCream,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderLg,
          side: const BorderSide(color: AppColors.creamBorder),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.warmIvory,
        foregroundColor: AppColors.deepCharcoal,
        elevation: 0,
        centerTitle: false,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.creamBorder, thickness: 1, space: 1),
    );
  }

  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.softSage,
      onPrimary: AppColors.deepCharcoal,
      primaryContainer: AppColors.sageDarkContainer,
      onPrimaryContainer: AppColors.softSage,
      secondary: AppColors.warmPeach,
      onSecondary: AppColors.deepCharcoal,
      secondaryContainer: AppColors.peachDarkContainer,
      onSecondaryContainer: AppColors.warmPeach,
      tertiary: AppColors.deepSage,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.sageDarkContainer,
      onTertiaryContainer: AppColors.softSage,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.error,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: AppColors.warmIvory,
      onInverseSurface: AppColors.deepCharcoal,
      inversePrimary: AppColors.deepSage,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: AppTextStyles.createTextTheme(Brightness.dark),
      inputDecorationTheme: AppInputDecoration.createTheme(Brightness.dark),
      elevatedButtonTheme: AppButtonTheme.createElevatedButtonTheme(Brightness.dark),
      outlinedButtonTheme: AppButtonTheme.createOutlinedButtonTheme(Brightness.dark),
      textButtonTheme: AppButtonTheme.createTextButtonTheme(Brightness.dark),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderLg,
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.darkBorder, thickness: 1, space: 1),
    );
  }
}
