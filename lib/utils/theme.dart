import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0a0a0f),
    primaryColor: const Color(0xFF00e5ff),
    cardColor: const Color(0xFF13131c),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.syne(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.syne(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -1.0,
      ),
      bodyLarge: GoogleFonts.dmMono(
        fontSize: 18,
        color: const Color(0xFFe8e8f0),
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.dmMono(
        fontSize: 14,
        color: const Color(0xFF6b6b80),
        height: 1.6,
      ),
      labelLarge: GoogleFonts.dmMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00e5ff),
      secondary: Color(0xFF7c3aed),
      surface: Color(0xFF111118),
    ),
  );
}
