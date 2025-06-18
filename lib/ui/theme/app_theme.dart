import 'package:flutter/material.dart';

class AppTheme {
  // Professional Brand Colors - Individual, not combo
  static const Color primaryNavy = Color(0xFF1E3A8A); // Professional Navy Blue
  static const Color accentGold = Color(0xFFD97706); // Professional Gold
  static const Color successGreen = Color(0xFF059669); // Success Green
  static const Color warningAmber = Color(0xFFF59E0B); // Warning Amber
  static const Color errorRed = Color(0xFFDC2626); // Error Red

  // Neutral Colors
  static const Color backgroundLight = Color(
    0xFFFAFAFA,
  ); // Clean Light Background
  static const Color backgroundDark = Color(0xFF0F172A); // Professional Dark
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure White
  static const Color surfaceDark = Color(0xFF1E293B); // Dark Surface
  static const Color textPrimary = Color(0xFF1F2937); // Dark Text
  static const Color textSecondary = Color(0xFF6B7280); // Secondary Text

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF1E3A8A, {
      50: const Color(0xFFEFF6FF),
      100: const Color(0xFFDBEAFE),
      200: const Color(0xFFBFDBFE),
      300: const Color(0xFF93C5FD),
      400: const Color(0xFF60A5FA),
      500: primaryNavy,
      600: const Color(0xFF1D4ED8),
      700: const Color(0xFF1E40AF),
      800: const Color(0xFF1E3A8A),
      900: const Color(0xFF1E3A8A),
    }),
    primaryColor: primaryNavy,
    scaffoldBackgroundColor: backgroundLight,
    cardColor: surfaceLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textSecondary),
      bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryNavy,
      brightness: Brightness.light,
      primary: primaryNavy,
      secondary: accentGold,
      error: errorRed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(0xFF3B82F6, {
      50: const Color(0xFF1E293B),
      100: const Color(0xFF334155),
      200: const Color(0xFF475569),
      300: const Color(0xFF64748B),
      400: const Color(0xFF94A3B8),
      500: const Color(0xFF3B82F6),
      600: const Color(0xFF2563EB),
      700: const Color(0xFF1D4ED8),
      800: const Color(0xFF1E40AF),
      900: const Color(0xFF1E3A8A),
    }),
    primaryColor: const Color(0xFF3B82F6),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFF1F5F9)),
      titleTextStyle: TextStyle(
        color: Color(0xFFF1F5F9),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFF1F5F9),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF1F5F9),
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF1F5F9),
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFCBD5E1)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3B82F6),
      brightness: Brightness.dark,
      primary: const Color(0xFF3B82F6),
      secondary: accentGold,
      error: errorRed,
    ),
  );
}
