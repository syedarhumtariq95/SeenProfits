import 'package:flutter/material.dart';

import '../../ui/generics/context/app_context.dart';
import 'routes.dart';

/// A service for managing screen navigation within the application.
///
/// This class provides methods for pushing new screens, replacing screens,
/// popping screens, and more, all while ensuring context safety.
class ScreenNavigationService {
  /// Private constructor to prevent instantiation.
  ScreenNavigationService._();

  /// Pushes a new screen onto the navigation stack using a class.
  ///
  /// Args:
  ///   screen: The widget representing the new screen to push.
  static void navigationPushWithClass(dynamic screen) {
    // Use AppContext to ensure context safety.
    AppContext.contextSafeFunction(() {
      // Push the new screen using MaterialPageRoute.
      Navigator.push(
        AppContext.getAppContext()!,
        MaterialPageRoute(builder: (context) => screen),
      );
    });
  }

  /// Pushes a new named route onto the navigation stack.
  ///
  /// Args:
  ///   route: The name of the route to push.
  ///   replacement: Whether to replace the current route. Defaults to false.
  ///   arguments: Arguments to pass to the new route.
  static void navigationPush(
    String route, {
    bool replacement = false,
    Object? arguments,
  }) {
    // Check if the route should replace the current route.
    if (replacement) {
      // Use AppContext to ensure context safety.
      AppContext.contextSafeFunction(() {
        // Push the new route and replace the current one.
        Navigator.pushReplacementNamed(
          AppContext.getAppContext()!,
          route,
          arguments: arguments,
        );
      });
    } else {
      // Use AppContext to ensure context safety.
      AppContext.contextSafeFunction(() {
        // Push the new route.
        Navigator.pushNamed(
          AppContext.getAppContext()!,
          route,
          arguments: arguments,
        );
      });
    }
  }

  /// Navigates to the splash screen and replaces all previous routes.
  ///
  /// This is typically used when switching languages or doing a major app reset.
  static void navigationSwitchLanguage() {
    // Use AppContext to ensure context safety.
    AppContext.contextSafeFunction(() {
      // Pop all routes until the first one.
      Navigator.popUntil(AppContext.getAppContext()!, (route) => route.isFirst);
      // Delay for a short duration to allow for visual transitions.
      Future.delayed(const Duration(milliseconds: 40), () {
        // Replace the current route with the splash screen route.
        Navigator.pushReplacementNamed(
          AppContext.getAppContext()!,
          // Navigate to the splash screen route.
          CustomRouter.splashScreenRouteName,
        );
      });
    });
  }

  /// Pops the current screen from the navigation stack.
  static void navigationPop() {
    // Use AppContext to ensure context safety.
    AppContext.contextSafeFunction(() {
      // Pop the current route.
      Navigator.pop(AppContext.getAppContext()!);
    });
  }

  /// Pushes a new route and removes all routes until a certain condition is met.
  ///
  /// Args:
  ///   routeToPush: The name of the route to push.
  ///   makeThisRouteRoot: Whether to make the new route the root route. Defaults to true.
  ///   routeToRemoveUntil: The name of the route to remove until. If null and makeThisRouteRoot is false, nothing happens.
  ///   arguments: Arguments to pass to the new route.
  static void navigationPushAndRemoveUntil({
    required String routeToPush,
    bool makeThisRouteRoot = true,
    String? routeToRemoveUntil,
    Object? arguments,
  }) {
    // Use AppContext to ensure context safety.
    AppContext.contextSafeFunction(() {
      // Check if the new route should be the root route.
      if (makeThisRouteRoot) {
        // Push the new route and remove all previous routes.
        Navigator.pushNamedAndRemoveUntil(
          AppContext.getAppContext()!,
          routeToPush,
          (route) => false,
          arguments: arguments,
        );
      } else {
        // Check if a route to remove until is specified.
        if (routeToRemoveUntil != null) {
          // Push the new route and remove all routes until the specified route.
          Navigator.pushNamedAndRemoveUntil(
            AppContext.getAppContext()!,
            routeToPush,
            ModalRoute.withName(routeToRemoveUntil),
            arguments: arguments,
          );
        }
      }
    });
  }

  /// Pops routes until the specified route is reached.
  ///
  /// Args:
  ///   route: The name of the route to pop until.
  static void navigationPopUntil(String route) {
    // Use AppContext to ensure context safety.
    AppContext.contextSafeFunction(() {
      // Pop routes until the specified route is found.
      Navigator.popUntil(
        AppContext.getAppContext()!,
        ModalRoute.withName(route),
      );
    });
  }

  /// Navigates to the login screen and removes all previous routes.
  ///
  /// This is used for logout functionality.
  static void logoutNavigation() {
    // Navigate to the login screen and remove all previous routes.
    navigationPushAndRemoveUntil(
      routeToPush: '', //CustomRouter.loginScreenRouteName, ///TODO
    );
  }
}
