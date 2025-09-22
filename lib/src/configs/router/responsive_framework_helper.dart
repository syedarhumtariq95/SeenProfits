import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'routes.dart';

/// A helper class for managing responsive layouts using the `responsive_framework` package.
///
/// This class provides methods for building responsive breakpoints,
/// managing max width boxes, and creating bouncing scroll wrappers.
class ResponsiveFrameworkHelper {
  /// Builds responsive breakpoints for the application.
  ///
  /// This method uses `ResponsiveBreakpoints.builder` to define
  /// the different breakpoints for mobile, tablet, desktop, and 4K screen sizes.
  ///
  /// Args:
  ///   child: The child widget that will be made responsive.
  ///
  /// Returns:
  ///   A responsive breakpoints widget.
  Widget responsiveBreakpointsBuilder(Widget child) {
    return ResponsiveBreakpoints.builder(
      child: child,
      breakpoints: [
        // Define the breakpoint for mobile devices.
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        // Define the breakpoint for tablets.
        const Breakpoint(start: 451, end: 800, name: TABLET),
        // Define the breakpoint for desktop screens.
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        // Define the breakpoint for 4K screens.
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }

  /// Creates a `MaxWidthBox` with responsive adjustments.
  ///
  /// This method uses `ResponsiveValue` to adjust the width based on the
  /// current breakpoint, ensuring that the content is appropriately sized
  /// for different screen sizes.
  ///
  /// Args:
  ///   context: The current build context.
  ///   child: The child widget that will be wrapped in the `MaxWidthBox`.
  ///
  /// Returns:
  ///   A `MaxWidthBox` with responsive adjustments.
  MaxWidthBox responsiveFrameworkMaxWidthBox(
    BuildContext context,
    Widget child,
  ) {
    // Determine the responsive value based on the current breakpoint.
    final value = ResponsiveValue(
      context,
      conditionalValues: [
        // For mobile devices, set the width to 450.
        const Condition.equals(name: MOBILE, value: 450),
        // For widths between 800 and 1100, set the width to 800.
        const Condition.between(start: 800, end: 1100, value: 800),
        // For widths between 1000 and 1200, set the width to 1000.
        const Condition.between(start: 1000, end: 1200, value: 1000),
        // There are no conditions for width over 1200
        // because the `maxWidth` is set to 1200 via the MaxWidthBox.
      ],
      // Default value for widths not covered by the conditional values.
      defaultValue: 800,
    ).value;

    return MaxWidthBox(
      // A widget that limits the maximum width.
      // This is used to create a gutter area on either side of the content.
      maxWidth: 1200,
      //background: Container(color: const Color(0xFFF5F5F5)),
      child: ResponsiveScaledBox(
        // ResponsiveScaledBox renders its child with a FittedBox set to the `width` value.
        // Set the fixed width value based on the active breakpoint.
        width: value.toDouble(),
        child: child,
      ),
    );
  }

  /// Builds a `BouncingScrollWrapper` for a given route.
  ///
  /// This method uses `BouncingScrollWrapper.builder` to create a scrollable
  /// area with bouncing physics.
  ///
  /// Args:
  ///   context: The current build context.
  ///   settings: The route settings for the current route.
  ///
  /// Returns:
  ///   A `BouncingScrollWrapper` widget.
  Widget bouncingScrollWrapperBuilder(
    BuildContext context,
    RouteSettings settings,
  ) {
    return BouncingScrollWrapper.builder(
      context,
      // Build the page based on the route name.
      buildPage(settings.name ?? '', context),
      dragWithMouse: true,
    );
  }

  /// Builds a page widget based on the route name.
  ///
  /// This method attempts to find a matching route in the `CustomRouter.routes`
  /// and return the corresponding widget. If no matching route is found, it returns an empty `SizedBox`.
  ///
  /// Args:
  ///   name: The name of the route.
  ///   context: The current build context.
  ///
  /// Returns:
  ///   The widget for the specified route, or an empty `SizedBox` if no route is found.
  Widget buildPage(String name, BuildContext context) {
    try {
      // Get a list of all route keys from the CustomRouter.
      final List<String> routerKeys = CustomRouter.routes.keys.toList();
      // Iterate through each route key.
      for (final route in routerKeys) {
        // Check if the route name matches the current route.
        if (route == name) {
          // Return the widget associated with the route.
          return CustomRouter.routes[name]!(context);
        }
      }
      // Return an empty SizedBox if no matching route is found.
      return const SizedBox.shrink();
    } catch (e) {
      // Return an empty SizedBox if an error occurs.
      return const SizedBox.shrink();
    }
  }
}
