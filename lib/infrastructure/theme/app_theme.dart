import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorName.background,
      colorScheme: const ColorScheme.light(
        primary: ColorName.primary,
        onPrimary: ColorName.textInverse,
        primaryContainer: ColorName.primaryLight,
        onPrimaryContainer: ColorName.textPrimary,
        secondary: ColorName.secondary,
        onSecondary: ColorName.textInverse,
        surface: ColorName.surface,
        onSurface: ColorName.textPrimary,
        error: ColorName.error,
        onError: ColorName.textInverse,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorName.primary,
        foregroundColor: ColorName.textInverse,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorName.textInverse),
        titleTextStyle: TextStyle(
          color: ColorName.textInverse,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: ColorName.textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: ColorName.textPrimary),
        bodyMedium: TextStyle(color: ColorName.textSecondary),
        bodySmall: TextStyle(color: ColorName.textSecondary),
        labelLarge: TextStyle(color: ColorName.primary, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorName.primary,
          foregroundColor: ColorName.textInverse,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorName.primary,
          side: const BorderSide(color: ColorName.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorName.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorName.surface,
        elevation: 2,
        shadowColor: ColorName.primary.withValues(alpha: 0.05),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorName.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(color: ColorName.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.error, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorName.surface,
        selectedItemColor: ColorName.primary,
        unselectedItemColor: ColorName.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      iconTheme: const IconThemeData(
        color: ColorName.primary,
        size: 24,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorName.primary,
        foregroundColor: ColorName.textInverse,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorName.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: ColorName.primaryDark,
        onPrimary: ColorName.textInverseDark,
        primaryContainer: ColorName.primary,
        onPrimaryContainer: ColorName.textPrimaryDark,
        secondary: ColorName.secondaryDark,
        onSecondary: ColorName.textInverseDark,
        surface: ColorName.surfaceDark,
        onSurface: ColorName.textPrimaryDark,
        error: ColorName.error,
        onError: ColorName.textInverse,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorName.backgroundDark,
        foregroundColor: ColorName.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorName.textPrimaryDark),
        titleTextStyle: TextStyle(
          color: ColorName.textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: ColorName.textPrimaryDark, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: ColorName.textPrimaryDark),
        bodyMedium: TextStyle(color: ColorName.textSecondaryDark),
        bodySmall: TextStyle(color: ColorName.textSecondaryDark),
        labelLarge: TextStyle(color: ColorName.primaryDark, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorName.primaryDark,
          foregroundColor: ColorName.textInverseDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorName.primaryDark,
          side: const BorderSide(color: ColorName.primaryDark, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorName.primaryDark,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorName.surfaceDark,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorName.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(color: ColorName.textSecondaryDark),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.primaryDark, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorName.error, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorName.surfaceDark,
        selectedItemColor: ColorName.primaryDark,
        unselectedItemColor: ColorName.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      iconTheme: const IconThemeData(
        color: ColorName.primaryDark,
        size: 24,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorName.primaryDark,
        foregroundColor: ColorName.textInverseDark,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
