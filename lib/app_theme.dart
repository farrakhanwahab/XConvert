import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _seaBlue = Color(0xFF1976D2); // Sea blue
  static const Color _lightGrey = Color(0xFFF5F6FA);
  static const Color _darkGrey = Color(0xFF222831);
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;

  // Custom colors for new converters
  static const Color areaGreen = Color(0xFF26A69A);      // Teal
  static const Color volumeIndigo = Color(0xFF5C6BC0);   // Indigo
  static const Color speedPurple = Color(0xFF7C4DFF);    // Deep Purple Accent
  static const Color timeOrange = Color(0xFFFFA726);     // Orange
  static const Color energyGreen = Color(0xFF43A047);    // Strong Green
  static const Color powerRed = Color(0xFFD32F2F);       // Red
  static const Color dataBlueGrey = Color(0xFF607D8B);   // Blue Grey
  static const Color freqDeepOrange = Color(0xFFFF7043); // Deep Orange Accent

  static TextTheme getTextTheme([Brightness brightness = Brightness.light]) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    return GoogleFonts.montserratTextTheme(base).copyWith(
      bodySmall: GoogleFonts.montserrat(fontSize: 12, color: base.bodySmall?.color),
      bodyMedium: GoogleFonts.montserrat(fontSize: 13, color: base.bodyMedium?.color),
      bodyLarge: GoogleFonts.montserrat(fontSize: 14, color: base.bodyLarge?.color), // Card body 14
      titleSmall: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: base.titleSmall?.color),
      titleMedium: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: base.titleMedium?.color), // Card heading 16
      titleLarge: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: base.titleLarge?.color), // App heading 16
      headlineSmall: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: base.headlineSmall?.color),
      headlineMedium: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold, color: base.headlineMedium?.color),
      headlineLarge: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: base.headlineLarge?.color),
      labelSmall: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w500, color: base.labelSmall?.color),
      labelMedium: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600, color: base.labelMedium?.color),
      labelLarge: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w700, color: base.labelLarge?.color),
      displaySmall: GoogleFonts.montserrat(fontSize: 26, fontWeight: FontWeight.bold, color: base.displaySmall?.color),
      displayMedium: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: base.displayMedium?.color),
      displayLarge: GoogleFonts.montserrat(fontSize: 40, fontWeight: FontWeight.bold, color: base.displayLarge?.color),
    );
  }

  static ThemeData lightTheme = ThemeData(
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
    textTheme: getTextTheme(Brightness.light),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  );

  static ThemeData darkTheme = ThemeData(
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
    textTheme: getTextTheme(Brightness.dark),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  );
} 