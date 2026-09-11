import 'package:flutter/material.dart';

import '../../configs/dependency_injection/dependency_injection.dart';
import '../../core/auth/admin_session.dart';
import '../../presentation/admin_shell/admin_shell.dart';
import '../../presentation/features/auth/forgot_password/forgot_password_screen.dart';
import '../../presentation/features/auth/login/admin_login_screen.dart';
import '../../presentation/features/auth/two_factor/admin_two_factor_screen.dart';
import '../../presentation/features/dashboard/dashboard_placeholder_screen.dart';
import '../../presentation/features/shared/coming_soon_screen.dart';
import 'admin_routes.dart';

class AdminRouter {
  AdminRouter._();

  static Route<void> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name ?? AdminRouteNames.login;
    final session = AdminDependencyInjection.get<AdminSession>();
    final resolvedRouteName = _resolveRoute(routeName, session);
    final Widget page;

    switch (resolvedRouteName) {
      case AdminRouteNames.login:
        page = const AdminLoginScreen();
      case AdminRouteNames.loginTwoFactor:
        page = const AdminTwoFactorScreen();
      case AdminRouteNames.forgotPassword:
        page = const ForgotPasswordScreen();
      case AdminRouteNames.dashboard:
        page = const AdminShell(
          routeName: AdminRouteNames.dashboard,
          child: DashboardPlaceholderScreen(),
        );
      default:
        page = AdminShell(
          routeName: resolvedRouteName,
          child: ComingSoonScreen(routeName: resolvedRouteName),
        );
    }

    return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
  }

  static String _resolveRoute(String routeName, AdminSession session) {
    const authRoutes = {
      AdminRouteNames.login,
      AdminRouteNames.loginTwoFactor,
      AdminRouteNames.forgotPassword,
    };
    final isAuthRoute = authRoutes.contains(routeName);

    if (session.isAuthenticated) {
      return isAuthRoute ? AdminRouteNames.dashboard : routeName;
    }
    if (session.isAwaitingTwoFactor) {
      return routeName == AdminRouteNames.loginTwoFactor
          ? routeName
          : AdminRouteNames.loginTwoFactor;
    }
    return isAuthRoute && routeName != AdminRouteNames.loginTwoFactor
        ? routeName
        : AdminRouteNames.login;
  }
}
