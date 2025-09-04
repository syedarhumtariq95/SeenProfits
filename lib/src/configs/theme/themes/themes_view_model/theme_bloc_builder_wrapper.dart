import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/theme_enum.dart';
import '../../theme_config.dart';
import '../themes_model/theme_bloc/theme_bloc.dart';

/// A wrapper widget that provides theme data to its descendants based on
/// the current theme state.
///
/// This widget listens to changes in the [ThemeBloc] and rebuilds
/// its [MaterialApp] child when the theme changes.
class ThemeBuilderWrapper extends StatelessWidget {
  /// Creates a [ThemeBuilderWrapper].
  ///
  /// Args:
  ///   child: The [MaterialApp] widget that will receive the theme data.
  const ThemeBuilderWrapper({super.key, required this.child});

  /// The [MaterialApp] widget that will receive the theme data.
  final MaterialApp child;

  @override
  Widget build(BuildContext context) {
    // Listen to the ThemeBloc for theme state changes.
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Determine the current theme based on the theme state.
        final theme = (themeState is ThemeFetched)
            ? AppThemeConfig().getThemeData(themeState.theme)
            : AppThemeConfig().getThemeData(ThemeFlavor.Default);
        // Build the MaterialApp with the determined theme.
        return MaterialApp(
          // Copy relevant properties from the original MaterialApp.
          navigatorKey: child.navigatorKey,
          debugShowCheckedModeBanner: child.debugShowCheckedModeBanner,
          // Apply the calculated theme data.
          theme: theme,
          locale: child.locale,
          supportedLocales: child.supportedLocales,
          localizationsDelegates: child.localizationsDelegates,
          builder: child.builder,
          initialRoute: child.initialRoute,
          onGenerateRoute: child.onGenerateRoute,
        );
      },
    );
  }
}
