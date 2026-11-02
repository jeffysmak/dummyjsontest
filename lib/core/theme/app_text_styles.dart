import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final class AppTextStyles {
  const AppTextStyles._();

  static const String primaryFontFamily = 'Plus Jakarta Sans';

  static const String serifFontFamily = 'Playfair Display';

  static TextTheme createTextTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color primaryColor = isDark ? AppColors.darkTextPrimary : AppColors.deepCharcoal;
    final Color secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.charcoalMuted;

    return TextTheme(
      // ── Display (Hero headings, splash numbers, major emphasis) ───────────
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 48.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        height: 1.15,
        color: primaryColor,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.75,
        height: 1.2,
        color: primaryColor,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.25,
        color: primaryColor,
      ),

      // ── Headline (Page titles, modal titles, section hero text) ───────────
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 26.0,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.28,
        color: primaryColor,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.15,
        height: 1.32,
        color: primaryColor,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 19.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.38,
        color: primaryColor,
      ),

      // ── Title (Card headers, list item titles, dialog headers) ────────────
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        height: 1.35,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        height: 1.4,
        color: primaryColor,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.42,
        color: primaryColor,
      ),

      // ── Body (Content paragraphs, descriptions, secondary copy) ───────────
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.5,
        color: primaryColor,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        height: 1.45,
        color: secondaryColor,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.4,
        color: secondaryColor,
      ),

      // ── Label (Buttons, badges, tabs, chips, form labels) ─────────────────
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        height: 1.3,
        color: primaryColor,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        height: 1.25,
        color: secondaryColor,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.2,
        color: secondaryColor,
      ),
    );
  }

  // ── Specialty & Semantic Text Styles ────────────────────────────────────────

  /// Serene editorial serif style for quotes and mindfulness statements.
  static TextStyle editorialQuote({
    required Brightness brightness,
    double fontSize = 15.0,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.italic,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final Color color = isDark ? AppColors.darkTextPrimary : AppColors.deepCharcoal;

    return GoogleFonts.playfairDisplay(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: 0.2,
      height: 1.5,
      color: color,
    );
  }

  /// Big statistical metric numbers (e.g. "12", "84 min", "12%").
  static TextStyle statNumber({
    required Brightness brightness,
    double fontSize = 28.0,
    FontWeight fontWeight = FontWeight.w800,
    Color? customColor,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final Color defaultColor = isDark ? AppColors.darkTextPrimary : AppColors.deepCharcoal;

    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: -0.5,
      height: 1.15,
      color: customColor ?? defaultColor,
    );
  }

  /// Primary button text style.
  static TextStyle button({
    required Brightness brightness,
    double fontSize = 15.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return GoogleFonts.plusJakartaSans(fontSize: fontSize, fontWeight: fontWeight, letterSpacing: 0.2, height: 1.3, color: color);
  }

  /// Input text field style.
  static TextStyle input({required Brightness brightness, double fontSize = 15.0, FontWeight fontWeight = FontWeight.w500}) {
    final bool isDark = brightness == Brightness.dark;
    final Color color = isDark ? AppColors.darkTextPrimary : AppColors.deepCharcoal;

    return GoogleFonts.plusJakartaSans(fontSize: fontSize, fontWeight: fontWeight, letterSpacing: 0.1, height: 1.4, color: color);
  }

  /// Input hint / placeholder text style.
  static TextStyle hint({required Brightness brightness, double fontSize = 14.0}) {
    final bool isDark = brightness == Brightness.dark;
    final Color color = isDark ? AppColors.darkTextSecondary : AppColors.charcoalMuted;

    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.4,
      color: color,
    );
  }

  /// Badge or chip pill text style.
  static TextStyle chip({
    required Brightness brightness,
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final Color defaultColor = isDark ? AppColors.darkTextPrimary : AppColors.deepCharcoal;

    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0.2,
      height: 1.25,
      color: color ?? defaultColor,
    );
  }
}
