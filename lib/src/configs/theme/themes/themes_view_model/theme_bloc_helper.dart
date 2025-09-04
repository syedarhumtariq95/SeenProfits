import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../enums/theme_enum.dart';
import '../themes_model/theme_bloc/theme_bloc.dart';

/// A helper class for managing theme-related actions.
///
/// This class provides static methods for interacting with the [ThemeBloc],
/// such as getting the current theme and switching between themes.
class ThemeBlocHelper {
  /// Private constructor to prevent instantiation.
  ///
  /// This class is designed to be used with static methods only.
  ThemeBlocHelper._();

  /// Retrieves the currently active theme flavor from the [ThemeBloc].
  ///
  /// This method accesses the [ThemeBloc] through the provided [BuildContext]
  /// and returns the currently set [ThemeFlavor]. If the theme hasn't been
  /// fetched yet, it defaults to [ThemeFlavor.Default].
  ///
  /// Args:
  ///   context: The [BuildContext] to access the [ThemeBloc].
  ///
  /// Returns:
  ///   The currently active [ThemeFlavor], or [ThemeFlavor.Default] if
  ///   the theme hasn't been fetched.
  static ThemeFlavor getCurrentThemeFlavor(BuildContext context) {
    // Get the current state from the ThemeBloc.
    final themeState = BlocProvider.of<ThemeBloc>(context).state;
    // Check if the state is ThemeFetched.
    if (themeState is ThemeFetched) {
      // Return the theme flavor from the state.
      return themeState.theme;
    }
    // Return the default theme if not fetched.
    return ThemeFlavor.Default;
  }

  /// Changes the current theme to the opposite theme.
  ///
  /// This method accesses the [ThemeBloc] through the provided [BuildContext]
  /// and dispatches a [SwitchAppTheme] event to toggle between the
  /// [ThemeFlavor.Dark] and [ThemeFlavor.Default] themes.
  ///
  /// Args:
  ///   context: The [BuildContext] to access the [ThemeBloc].
  static void changeTheme(BuildContext context) {
    // Access the ThemeBloc.
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // Get the current state from the bloc.
    final themeState = themeBloc.state;
    // Check if the theme is fetched.
    if (themeState is ThemeFetched) {
      // Check if the current theme is dark.
      if (themeState.theme.name == ThemeFlavor.Dark.name) {
        // Change to the default theme.
        themeBloc.add(SwitchAppTheme(updatedFlavor: ThemeFlavor.Default));
      }
      // Check if the current theme is default.
      if (themeState.theme.name == ThemeFlavor.Default.name) {
        // Change to the dark theme.
        themeBloc.add(SwitchAppTheme(updatedFlavor: ThemeFlavor.Dark));
      }
    }
  }
}
