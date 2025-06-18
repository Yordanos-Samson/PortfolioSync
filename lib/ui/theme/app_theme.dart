import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color accentTeal = Color(0xFF0D9488);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF2563EB, {
      50: const Color(0xFFEFF6FF),
      100: const Color(0xFFDBEAFE),
      200: const Color(0xFFBFDBFE),
      300: const Color(0xFF93C5FD),
      400: const Color(0xFF60A5FA),
      500: primaryBlue,
      600: const Color(0xFF1D4ED8),
      700: const Color(0xFF1E40AF),
      800: const Color(0xFF1E3A8A),
      900: const Color(0xFF1E3A8A),
    }),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF1E293B)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
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
        color: Color(0xFF1E293B),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF475569)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
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
    scaffoldBackgroundColor: backgroundDark,
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
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
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
  );
}
