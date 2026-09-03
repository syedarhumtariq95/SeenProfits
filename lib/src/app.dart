import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import 'configs/app/screen_config.dart';
import 'configs/bloc/bloc_initializer.dart';
import 'configs/dependency_injection/dependency_injection.dart';
import 'configs/dependency_injection/navigation_service.dart';
import 'configs/router/responsive_framework_helper.dart';
import 'configs/router/route_animation.dart';
import 'configs/router/routes.dart';
import 'configs/theme/theme_config.dart';
import 'configs/theme/themes/themes_view_model/theme_bloc_builder_wrapper.dart';
import 'configs/theme/themes/themes_view_model/theme_bloc_helper.dart';
import 'ui/generics/widgets/focus_handler/focus_handle_wrapper.dart';
import 'ui/generics/widgets/route/conditional_route.dart';

/// The root widget of the application.
///
/// This widget is responsible for setting up the app's theme,
/// routing, localization, and other configurations.
class App extends StatelessWidget {
  /// Creates an [App] widget.
  ///
  /// The [key] parameter is optional and is used for widget identification.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the screen configuration.
    ScreenConfig().init(context);
    // Create an instance of the AppThemeConfig to manage theme data.
    final AppThemeConfig appThemeConfig = AppThemeConfig();
    // Create an instance of the ResponsiveFrameworkHelper for responsive layouts.
    final ResponsiveFrameworkHelper responsiveFrameworkHelper =
        ResponsiveFrameworkHelper();
    // Wrap the app with BlocInitializer to initialize blocs.
    return BlocInitializer(
      child: FocusHandler(
        // Used to control the focus.
        child: MediaQuery(
          // Lock the text scale factor to 1.0 to prevent text scaling.
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1)),
          child: ScreenUtilInit(
            // Set the design size for responsive layout calculations.
            designSize: Size(
              ScreenConfig.screenSizeWidth,
              ScreenConfig.screenSizeHeight,
            ),
            builder: (context, _) => ThemeBuilderWrapper(
              child: MaterialApp(
                // Set the navigator key for navigation.
                navigatorKey: DI.i<NavigationService>().navigationKey,
                // Disable the debug banner.
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appName,
                // Set the app's theme based on the current theme flavor.
                theme: appThemeConfig.getThemeData(
                  ThemeBlocHelper.getCurrentThemeFlavor(context),
                ),
                // Use ResponsiveFrameworkHelper to manage responsive breakpoints.
                builder: (context, child) => responsiveFrameworkHelper
                    .responsiveBreakpointsBuilder(child!),
                // Set the initial route of the app.
                initialRoute: CustomRouter.splashScreenRouteName,
                // Generate routes dynamically based on the settings.
                onGenerateRoute: (RouteSettings settings) {
                  // Use fadeThrough animation for route transitions.
                  return Routes.fadeThrough(settings, (context) {
                    // Use ConditionalRouteWidget for conditional route building.
                    return ConditionalRouteWidget(
                      builder: (context, child) => responsiveFrameworkHelper
                          .responsiveFrameworkMaxWidthBox(context, child!),
                      // List of available routes.
                      routes: CustomRouter.routes.keys.toList(),
                      // Wrap the child with a bouncing scroll wrapper.
                      child: responsiveFrameworkHelper
                          .bouncingScrollWrapperBuilder(context, settings),
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
