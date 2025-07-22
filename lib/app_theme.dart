import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _seaBlue = Color(0xFF0A4D68);
  static const _lightGrey = Color(0xFFF0F0F0);
  static const _darkGrey = Color(0xFF2E2E2E);
  static const _white = Colors.white;
  static const _black = Colors.black;

  // Additional colors for categories
  static const Color areaGreen = Color(0xFF388E3C);
  static const Color volumeIndigo = Color(0xFF3F51B5);
  static const Color speedPurple = Color(0xFF9C27B0);
  static const Color timeOrange = Color(0xFFFF9800);
  static const Color energyGreen = Color(0xFF4CAF50);
  static const Color powerRed = Color(0xFFF44336);
  static const Color dataBlueGrey = Color(0xFF607D8B);
  static const Color freqDeepOrange = Color(0xFFFF5722);

  static TextTheme getTextTheme(Brightness brightness) {
    return getTextThemeWithScale(1.0, brightness);
  }

  static TextTheme getTextThemeWithScale(double scale, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;

    TextStyle? scaleStyle(TextStyle? style, double size) =>
        style?.copyWith(fontSize: size * scale);

    return GoogleFonts.montserratTextTheme(base).copyWith(
      bodySmall: scaleStyle(GoogleFonts.montserrat(color: base.bodySmall?.color), 12),
      bodyMedium: scaleStyle(GoogleFonts.montserrat(color: base.bodyMedium?.color), 13),
      bodyLarge: scaleStyle(GoogleFonts.montserrat(color: base.bodyLarge?.color), 14),
      titleSmall: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: base.titleSmall?.color), 14),
      titleMedium: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: base.titleMedium?.color), 16),
      titleLarge: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.titleLarge?.color), 16),
      headlineSmall: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.headlineSmall?.color), 20),
      headlineMedium: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.headlineMedium?.color), 22),
      headlineLarge: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.headlineLarge?.color), 24),
      labelSmall: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: base.labelSmall?.color), 11),
      labelMedium: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: base.labelMedium?.color), 12),
      labelLarge: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: base.labelLarge?.color), 13),
      displaySmall: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.displaySmall?.color), 26),
      displayMedium: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.displayMedium?.color), 32),
      displayLarge: scaleStyle(GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: base.displayLarge?.color), 40),
    );
  }

  static ThemeData lightTheme(double fontScale) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: _seaBlue,
        onPrimary: _white,
        secondary: _darkGrey,
        onSecondary: _white,
        error: Colors.red,
        onError: _white,
        surface: _white,
        onSurface: _darkGrey,
        primaryContainer: _seaBlue.withAlpha(30),
        onPrimaryContainer: _seaBlue,
        secondaryContainer: _lightGrey,
        onSecondaryContainer: _darkGrey,
        surfaceContainerHighest: _lightGrey,
        onSurfaceVariant: _darkGrey,
        outline: _seaBlue.withAlpha(51),
        outlineVariant: _lightGrey,
        scrim: Colors.black12,
        inverseSurface: _darkGrey,
        onInverseSurface: _white,
        inversePrimary: _seaBlue,
        shadow: Colors.black12,
      ),
      textTheme: getTextThemeWithScale(fontScale, Brightness.light),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  static ThemeData darkTheme(double fontScale) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: _seaBlue,
        onPrimary: _white,
        secondary: _lightGrey,
        onSecondary: _darkGrey,
        error: Colors.red.shade200,
        onError: _black,
        surface: _darkGrey,
        onSurface: _white,
        primaryContainer: _seaBlue.withAlpha(46),
        onPrimaryContainer: _seaBlue,
        secondaryContainer: _darkGrey,
        onSecondaryContainer: _white,
        surfaceContainerHighest: _darkGrey,
        onSurfaceVariant: _white,
        outline: _seaBlue.withAlpha(77),
        outlineVariant: _darkGrey,
        scrim: Colors.black54,
        inverseSurface: _white,
        onInverseSurface: _darkGrey,
        inversePrimary: _seaBlue,
        shadow: Colors.black45,
      ),
      textTheme: getTextThemeWithScale(fontScale, Brightness.dark),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}