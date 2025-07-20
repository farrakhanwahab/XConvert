import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _seaBlue = Color(0xFF1976D2); // Sea blue
  static const Color _lightGrey = Color(0xFFF5F6FA);
  static const Color _darkGrey = Color(0xFF222831);
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;

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
    textTheme: GoogleFonts.montserratTextTheme(),
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
    textTheme: GoogleFonts.montserratTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  );
} 