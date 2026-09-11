import 'package:flutter/material.dart';

import 'admin_theme_colors.dart';

class AdminThemeConfig {
  AdminThemeConfig._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AdminThemeColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AdminThemeColors.purple,
      secondary: AdminThemeColors.pink,
      surface: AdminThemeColors.surface,
      onSurface: AdminThemeColors.text,
      outline: AdminThemeColors.outline,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AdminThemeColors.sidebar,
      foregroundColor: AdminThemeColors.text,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AdminThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dividerTheme: const DividerThemeData(color: AdminThemeColors.outline),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AdminThemeColors.surfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AdminThemeColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AdminThemeColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AdminThemeColors.purple, width: 1.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: AdminThemeColors.mutedText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AdminThemeColors.purple,
        foregroundColor: AdminThemeColors.text,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
