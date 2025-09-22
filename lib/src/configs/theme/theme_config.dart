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
    textTheme: FontTheme().textTheme,

    /// Card color in the light theme.
    cardColor: ThemeColors.kBoxColor,

    /// Primary color in the light theme.
    primaryColor: ThemeColors.kThemeColor,

    /// Shadow color in the light theme.
    shadowColor: ThemeColors.kCardShadowColor,

    /// Color scheme for the light theme.
    colorScheme: const ColorScheme.light().copyWith(
      primary: ThemeColors.kThemeColor,
    ),

    /// Progress indicator theme for the light theme.
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ThemeColors.kThemeColor,
    ),

    /// Scaffold background color in the light theme.
    scaffoldBackgroundColor: ThemeColors.kScaffoldBackgroundColor,

    /// Font family for the light theme.
    fontFamily: FontsConfigs.poppinsFonts,

    /// App bar theme for the light theme.
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.kAppBarColor,
      iconTheme: IconThemeData(color: ThemeColors.kIconColor),
    ),

    /// Bottom navigation bar theme for the light theme.
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ThemeColors.kBottomNavigationBarBackgroundColor,
      selectedItemColor: ThemeColors.kBottomNavigationBarTextSelectedColor,
      unselectedItemColor: ThemeColors.kBottomNavigationBarTextUnselectedColor,
    ),

    /// Button theme for the light theme.
    buttonTheme: const ButtonThemeData(
      buttonColor: ThemeColors.kButtonColor,
      disabledColor: ThemeColors.kButtonSecondaryColor,
    ),

    /// Page transitions theme for the light theme.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.iOS: ZoomPageTransitionsBuilder()},
    ),
  );

  // Dark Theme
  /// The dark theme data for the application.
  final ThemeData _darkTheme = ThemeData(
    /// Card color in the dark theme.
    cardColor: ThemeColors.kDarkBoxColor,

    /// Primary color in the dark theme.
    primaryColor: ThemeColors.kThemePrimaryColor,

    /// Scaffold background color in the dark theme.
    scaffoldBackgroundColor: ThemeColors.kDarkScaffoldBackgroundColor,

    /// Color scheme for the dark theme.
    colorScheme: const ColorScheme.dark(),

    /// Font family for the dark theme.
    fontFamily: FontsConfigs.poppinsFonts,

    /// Input decoration theme for the dark theme.
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: ThemeColors.kThemePrimaryColor),
    ),

    /// Shadow color in the dark theme.
    shadowColor: ThemeColors.kDarkCardShadowColor,

    /// App bar theme for the dark theme.
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.kDarkAppBarColor,
      iconTheme: IconThemeData(color: ThemeColors.kButtonTextColor),
    ),

    /// Bottom navigation bar theme for the dark theme.
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ThemeColors.kButtonDarkBlueColor,
      selectedItemColor: ThemeColors.kBottomNavigationBarTextSelectedColor,
      unselectedItemColor: ThemeColors.kFontHintColor,
    ),

    /// Button theme for the dark theme.
    buttonTheme: const ButtonThemeData(
      buttonColor: ThemeColors.kButtonDarkBlueColor,
      disabledColor: ThemeColors.kFontTabBarUnselectedColor,
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
