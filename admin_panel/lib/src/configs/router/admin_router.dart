import 'package:go_router/go_router.dart';

import '../../configs/dependency_injection/dependency_injection.dart';
import '../../core/auth/admin_session.dart';
import '../../domain/models/user_model.dart';
import '../../presentation/admin_shell/admin_shell.dart';
import '../../presentation/features/auth/forgot_password/forgot_password_screen.dart';
import '../../presentation/features/auth/login/admin_login_screen.dart';
import '../../presentation/features/auth/two_factor/admin_two_factor_screen.dart';
import '../../presentation/features/business_management/business_management_screen.dart';
import '../../presentation/features/categories/category_management_screen.dart';
import '../../presentation/features/dashboard/dashboard_screen.dart';
import '../../presentation/features/deal_management/deal_management_screen.dart';
import '../../presentation/features/profit_distribution/profit_distribution_screen.dart';
import '../../presentation/features/reports/reports_analytics_screen.dart';
import '../../presentation/features/notifications/notification_management_screen.dart';
import '../../presentation/features/shared/coming_soon_screen.dart';
import '../../presentation/features/user_management/user_management_screen.dart';
import '../../presentation/features/verification/verification_screen.dart';
import 'admin_routes.dart';

class AdminRouter {
  AdminRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AdminRouteNames.login,
    redirect: (context, state) {
      final session = AdminDependencyInjection.get<AdminSession>();
      final location = state.uri.path;
      const authRoutes = {
        AdminRouteNames.login,
        AdminRouteNames.loginTwoFactor,
        AdminRouteNames.forgotPassword,
      };

      if (session.isAuthenticated) {
        return authRoutes.contains(location) ? AdminRouteNames.dashboard : null;
      }
      if (session.isAwaitingTwoFactor) {
        return location == AdminRouteNames.loginTwoFactor
            ? null
            : AdminRouteNames.loginTwoFactor;
      }
      return authRoutes.contains(location) &&
              location != AdminRouteNames.loginTwoFactor
          ? null
          : AdminRouteNames.login;
    },
    routes: [
      GoRoute(
        path: AdminRouteNames.login,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: AdminRouteNames.loginTwoFactor,
        builder: (context, state) => const AdminTwoFactorScreen(),
      ),
      GoRoute(
        path: AdminRouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AdminShell(
          routeName: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: AdminRouteNames.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.businesses,
            builder: (context, state) => const BusinessManagementScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.verification,
            builder: (context, state) => const VerificationScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.investors,
            builder: (context, state) =>
                const UserManagementScreen(initialRole: UserRole.investor),
          ),
          GoRoute(
            path: AdminRouteNames.businessOwners,
            builder: (context, state) => const UserManagementScreen(
              initialRole: UserRole.businessOwner,
            ),
          ),
          GoRoute(
            path: AdminRouteNames.investmentRequests,
            builder: (context, state) => const DealManagementScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.profitDistribution,
            builder: (context, state) => const ProfitDistributionScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.reports,
            builder: (context, state) => const ReportsAnalyticsScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.analytics,
            builder: (context, state) => const ReportsAnalyticsScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.categories,
            builder: (context, state) => const CategoryManagementScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.notifications,
            builder: (context, state) => const NotificationManagementScreen(),
          ),
          GoRoute(
            path: AdminRouteNames.content,
            builder: (context, state) =>
                const ComingSoonScreen(routeName: AdminRouteNames.content),
          ),
          GoRoute(
            path: AdminRouteNames.auditLogs,
            builder: (context, state) =>
                const ComingSoonScreen(routeName: AdminRouteNames.auditLogs),
          ),
          GoRoute(
            path: AdminRouteNames.adminAccounts,
            builder: (context, state) => const ComingSoonScreen(
              routeName: AdminRouteNames.adminAccounts,
            ),
          ),
          GoRoute(
            path: AdminRouteNames.settings,
            builder: (context, state) =>
                const ComingSoonScreen(routeName: AdminRouteNames.settings),
          ),
        ],
      ),
    ],
  );
}
