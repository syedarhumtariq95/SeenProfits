import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import '../../../localization/locale_bloc/locale_bloc.dart';
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
      builder: (context, themeState) => BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, localeState) {
          final theme = (themeState is ThemeFetched)
              ? AppThemeConfig().getThemeData(themeState.theme)
              : AppThemeConfig().getThemeData(ThemeFlavor.Default);
          return MaterialApp(
            navigatorKey: child.navigatorKey,
            debugShowCheckedModeBanner: child.debugShowCheckedModeBanner,
            onGenerateTitle: child.onGenerateTitle,
            theme: theme,
            locale: localeState.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            builder: child.builder,
            initialRoute: child.initialRoute,
            onGenerateRoute: child.onGenerateRoute,
          );
        },
      ),
    );
  }
}
