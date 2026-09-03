import 'package:flutter/material.dart';

import '../../ui/presentation/screens/auth/auth_entry_screen.dart';
import '../../ui/presentation/screens/auth/auth_placeholder_screen.dart';
import '../../ui/presentation/screens/onboarding/role_selection_screen.dart';
import '../../ui/presentation/screens/splash/splash_screen.dart';

/// A class for managing the application's routes.
///
/// This class defines the route names and their corresponding widgets,
/// allowing for centralized management of the navigation system.
class CustomRouter {
  /// Private constructor to prevent instantiation.
  CustomRouter._();

  // Feature: Onboarding routes
  /// Route name for the splash screen.
  static const String splashScreenRouteName = '/';
  static const String roleSelectionRouteName = '/role-selection';
  static const String businessAuthRouteName = '/business/auth';
  static const String businessLoginRouteName = '/business/login';
  static const String businessRegisterRouteName = '/business/register';
  static const String investorAuthRouteName = '/investor/auth';
  static const String investorLoginRouteName = '/investor/login';
  static const String investorRegisterRouteName = '/investor/register';

  /// A map of route names to their corresponding widget builders.
  ///
  /// This map defines the routes and the widgets that should be displayed
  /// when navigating to those routes.
  static final Map<String, Widget Function(BuildContext)> routes = {
    // Route for the splash screen.
    splashScreenRouteName: (BuildContext context) => const SplashScreen(),
    roleSelectionRouteName: (BuildContext context) =>
        const RoleSelectionScreen(),
    businessAuthRouteName: (BuildContext context) =>
        const AuthEntryScreen(role: SeenProfitsRole.business),
    businessLoginRouteName: (BuildContext context) =>
        const AuthPlaceholderScreen(
          role: SeenProfitsRole.business,
          isLogin: true,
        ),
    businessRegisterRouteName: (BuildContext context) =>
        const AuthPlaceholderScreen(
          role: SeenProfitsRole.business,
          isLogin: false,
        ),
    investorAuthRouteName: (BuildContext context) =>
        const AuthEntryScreen(role: SeenProfitsRole.investor),
    investorLoginRouteName: (BuildContext context) =>
        const AuthPlaceholderScreen(
          role: SeenProfitsRole.investor,
          isLogin: true,
        ),
    investorRegisterRouteName: (BuildContext context) =>
        const AuthPlaceholderScreen(
          role: SeenProfitsRole.investor,
          isLogin: false,
        ),
  };
}
