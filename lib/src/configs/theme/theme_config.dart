import 'package:flutter/material.dart';

import '../app/fonts_configs.dart';
import 'theme_colors.dart';
import 'enums/theme_enum.dart';

/// Configuration class for defining application themes.
///
/// This class provides pre-defined light and dark themes, and allows
/// retrieval of the appropriate theme based on the specified [ThemeFlavor].
class AppThemeConfig {
  /// Key used for storing and retrieving theme preference in local storage.
  final String themeStorageKey = 'theme';

  // Light Theme
  /// The light theme data for the application.
  final ThemeData _theme = ThemeData(
    textTheme: FontTheme().textTheme.apply(
          bodyColor: ThemeColors.seenProfitsText,
          displayColor: ThemeColors.seenProfitsText,
        ),

    /// Card color in the light theme.
    cardColor: ThemeColors.seenProfitsSurface,

    /// Primary color in the light theme.
    primaryColor: ThemeColors.seenProfitsPurple,

    /// Shadow color in the light theme.
    shadowColor: Colors.black,

    /// Color scheme for the light theme.
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ThemeColors.seenProfitsPurple,
      secondary: ThemeColors.seenProfitsPink,
      surface: ThemeColors.seenProfitsSurface,
      onSurface: ThemeColors.seenProfitsText,
      onSurfaceVariant: ThemeColors.seenProfitsMutedText,
      outline: ThemeColors.seenProfitsOutline,
      outlineVariant: ThemeColors.seenProfitsOutline,
    ),

    /// Progress indicator theme for the light theme.
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ThemeColors.seenProfitsPurple,
    ),

    /// Scaffold background color in the light theme.
    scaffoldBackgroundColor: ThemeColors.seenProfitsDark,

    /// Font family for the light theme.
    fontFamily: FontsConfigs.poppinsFonts,

    /// App bar theme for the light theme.
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.seenProfitsDark,
      foregroundColor: ThemeColors.seenProfitsText,
      iconTheme: IconThemeData(color: ThemeColors.seenProfitsText),
    ),

    /// Bottom navigation bar theme for the light theme.
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ThemeColors.seenProfitsSurface,
      selectedItemColor: ThemeColors.seenProfitsPink,
      unselectedItemColor: ThemeColors.seenProfitsMutedText,
    ),

    /// Button theme for the light theme.
    buttonTheme: const ButtonThemeData(
      buttonColor: ThemeColors.seenProfitsPurple,
      disabledColor: ThemeColors.seenProfitsSurfaceVariant,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.seenProfitsPurple,
        foregroundColor: ThemeColors.seenProfitsText,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeColors.seenProfitsPink,
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: ThemeColors.seenProfitsPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ThemeColors.seenProfitsPink),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ThemeColors.seenProfitsSurface,
      labelStyle: const TextStyle(
        color: ThemeColors.seenProfitsMutedText,
        fontSize: 15,
      ),
      hintStyle: const TextStyle(
        color: ThemeColors.seenProfitsMutedText,
        fontSize: 15,
      ),
      prefixIconColor: ThemeColors.seenProfitsMutedText,
      suffixIconColor: ThemeColors.seenProfitsMutedText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.seenProfitsOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.seenProfitsOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: ThemeColors.seenProfitsPink, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.kErrorRedColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: ThemeColors.kErrorRedColor, width: 1.5),
      ),
    ),

    /// Page transitions theme for the light theme.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.iOS: ZoomPageTransitionsBuilder()},
    ),
  );

  // Dark Theme
  /// The dark theme data for the application.
  final ThemeData _darkTheme = ThemeData(
    textTheme: FontTheme().textTheme.apply(
          bodyColor: ThemeColors.seenProfitsText,
          displayColor: ThemeColors.seenProfitsText,
        ),

    /// Card color in the dark theme.
    cardColor: ThemeColors.seenProfitsSurface,

    /// Primary color in the dark theme.
    primaryColor: ThemeColors.seenProfitsPurple,

    /// Scaffold background color in the dark theme.
    scaffoldBackgroundColor: ThemeColors.seenProfitsDark,

    /// Color scheme for the dark theme.
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ThemeColors.seenProfitsPurple,
      secondary: ThemeColors.seenProfitsPink,
      surface: ThemeColors.seenProfitsSurface,
      onSurface: ThemeColors.seenProfitsText,
      onSurfaceVariant: ThemeColors.seenProfitsMutedText,
      outline: ThemeColors.seenProfitsOutline,
      outlineVariant: ThemeColors.seenProfitsOutline,
    ),

    /// Font family for the dark theme.
    fontFamily: FontsConfigs.poppinsFonts,

    /// Input decoration theme for the dark theme.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ThemeColors.seenProfitsSurface,
      floatingLabelStyle: const TextStyle(color: ThemeColors.seenProfitsPink),
      labelStyle: const TextStyle(
        color: ThemeColors.seenProfitsMutedText,
        fontSize: 15,
      ),
      hintStyle: const TextStyle(
        color: ThemeColors.seenProfitsMutedText,
        fontSize: 15,
      ),
      prefixIconColor: ThemeColors.seenProfitsMutedText,
      suffixIconColor: ThemeColors.seenProfitsMutedText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.seenProfitsOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.seenProfitsOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: ThemeColors.seenProfitsPink, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.kErrorRedColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: ThemeColors.kErrorRedColor, width: 1.5),
      ),
    ),

    /// Shadow color in the dark theme.
    shadowColor: ThemeColors.kDarkCardShadowColor,

    /// App bar theme for the dark theme.
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.seenProfitsDark,
      foregroundColor: ThemeColors.seenProfitsText,
      iconTheme: IconThemeData(color: ThemeColors.seenProfitsText),
    ),

    /// Bottom navigation bar theme for the dark theme.
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ThemeColors.seenProfitsSurface,
      selectedItemColor: ThemeColors.seenProfitsPink,
      unselectedItemColor: ThemeColors.seenProfitsMutedText,
    ),

    /// Button theme for the dark theme.
    buttonTheme: const ButtonThemeData(
      buttonColor: ThemeColors.seenProfitsPurple,
      disabledColor: ThemeColors.seenProfitsSurfaceVariant,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeColors.seenProfitsPink,
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: ThemeColors.seenProfitsPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ThemeColors.seenProfitsPink),
    ),

    /// Page transitions theme for the dark theme.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.iOS: ZoomPageTransitionsBuilder()},
    ),
  );

  /// Returns the appropriate [ThemeData] based on the specified [ThemeFlavor].
  ///
  /// Args:
  ///   flavor: The desired theme flavor ([ThemeFlavor.Dark] or any other).
  ///
  /// Returns:
  ///   The corresponding [ThemeData] for the given [ThemeFlavor].
  ThemeData getThemeData(ThemeFlavor flavor) {
    // Check if the dark theme is requested.
    if (flavor == ThemeFlavor.Dark) {
      // Return the dark theme.
      return _darkTheme;
    }
    // Return the light theme by default.
    return _theme;
  }
}
