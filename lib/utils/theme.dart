import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF060814),
    primaryColor: const Color(0xFF00E5FF),
    cardColor: const Color(0x1AFFFFFF),
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
        color: const Color(0xFFE2E8F0),
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.dmMono(
        fontSize: 14,
        color: const Color(0xFF94A3B8),
        height: 1.6,
      ),
      labelLarge: GoogleFonts.dmMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00E5FF),
      secondary: Color(0xFF8B5CF6),
      surface: Color(0x1AFFFFFF),
    ),
  );
}
