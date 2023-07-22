import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/assets.gen.dart';
import 'color_values.dart';

class AppThemeData {
  static ThemeData getThemeLight() {
    const Color primaryColor = ColorValues.green02;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };

    final MaterialColor primaryMaterialColor =
    MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme.fromSeed(seedColor: ColorValues.green02),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => Assets.icons.arrow.svg(),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleSpacing: 8,
        titleTextStyle: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorValues.green02,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 40),
          textStyle: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelMedium: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: GoogleFonts.nunito(
          color: ColorValues.grey04,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.nunito(
          color: ColorValues.grey04,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.nunito(
          color: ColorValues.grey04,
          fontSize: 12,
        ),
      ),
    );
  }
}
