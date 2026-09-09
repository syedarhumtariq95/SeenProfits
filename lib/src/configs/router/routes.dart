import 'package:flutter/material.dart';

import '../../ui/presentation/screens/auth/auth_entry_screen.dart';
import '../../ui/presentation/screens/auth/authentication_screens.dart';
import '../../ui/presentation/screens/onboarding/role_selection_screen.dart';
import '../../ui/presentation/screens/splash/splash_screen.dart';
import '../../ui/presentation/screens/home/home_screens.dart';
import '../../ui/presentation/screens/business/add_business/add_business_screen.dart';
import '../../ui/presentation/screens/business/chats/business_chat_list_screen.dart';
import '../../ui/presentation/screens/business/opportunity/seek_investment_screen.dart';
import '../../ui/presentation/screens/business/profile/business_profile_settings_screen.dart';
import '../../ui/presentation/screens/business/requests/business_requests_screen.dart';
import '../../ui/presentation/screens/business/verification/verification_screen.dart';
import '../../ui/presentation/screens/investor/favorites/favorites_screen.dart';
import '../../ui/presentation/screens/notifications/notifications_screen.dart';
import '../../ui/presentation/screens/home/investor_screens.dart';
import '../../ui/presentation/screens/investor/business_detail/investor_business_detail_screen.dart';
import '../../ui/presentation/screens/investor/home/investor_home_screen.dart'
    hide InvestorHomeScreen;

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
  static const String authenticationEntryRouteName = '/auth';
  static const String loginRouteName = '/login';
  static const String registerRouteName = '/register';
  static const String otpRouteName = '/otp';
  static const String forgotPasswordRouteName = '/forgot-password';
  static const String resetPasswordRouteName = '/reset-password';
  static const String roleSelectionRouteName = '/role-selection';
  static const String businessAuthRouteName = '/business/auth';
  static const String businessLoginRouteName = '/business/login';
  static const String businessRegisterRouteName = '/business/register';
  static const String businessOtpRouteName = '/business/otp';
  static const String businessForgotPasswordRouteName =
      '/business/forgot-password';
  static const String businessResetPasswordRouteName =
      '/business/reset-password';
  static const String businessHomeRouteName = '/business/home';
  static const String businessDetailsRouteName = '/business/details';
  static const String chatRouteName = '/chat';
  static const String addBusinessRouteName = '/business/add';
  static const String verificationRouteName = '/business/verification';
  static const String seekInvestmentRouteName = '/business/seek-investment';
  static const String notificationsRouteName = '/notifications';
  static const String favoritesRouteName = '/favorites';
  static const String profileSettingsRouteName = '/profile-settings';
  static const String businessRequestsRouteName = '/business/requests';
  static const String businessChatsRouteName = '/business/chats';
  static const String businessProfileRouteName = '/business/profile';
  static const String investorAuthRouteName = '/investor/auth';
  static const String investorLoginRouteName = '/investor/login';
  static const String investorRegisterRouteName = '/investor/register';
  static const String investorOtpRouteName = '/investor/otp';
  static const String investorForgotPasswordRouteName =
      '/investor/forgot-password';
  static const String investorResetPasswordRouteName =
      '/investor/reset-password';
  static const String investorHomeRouteName = '/investor/home';
  static const String investorRequestsRouteName = '/investor/requests';
  static const String investorFiltersRouteName = '/investor/filters';
  static const String ratingsRouteName = '/ratings-reviews';
  static const String settingsRouteName = '/settings';

  /// A map of route names to their corresponding widget builders.
  ///
  /// This map defines the routes and the widgets that should be displayed
  /// when navigating to those routes.
  static final Map<String, Widget Function(BuildContext)> routes = {
    // Route for the splash screen.
    splashScreenRouteName: (BuildContext context) => const SplashScreen(),
    authenticationEntryRouteName: (BuildContext context) =>
        const AuthEntryScreen(),
    loginRouteName: (BuildContext context) => const AuthenticationScreen(
          page: AuthenticationPage.login,
        ),
    registerRouteName: (BuildContext context) => const AuthenticationScreen(
          page: AuthenticationPage.register,
        ),
    otpRouteName: (BuildContext context) => const AuthenticationScreen(
          page: AuthenticationPage.otp,
        ),
    forgotPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(page: AuthenticationPage.forgotPassword),
    resetPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(page: AuthenticationPage.resetPassword),
    roleSelectionRouteName: (BuildContext context) =>
        const RoleSelectionScreen(),
    businessAuthRouteName: (BuildContext context) =>
        const AuthEntryScreen(role: SeenProfitsRole.business),
    businessLoginRouteName: (BuildContext context) =>
        const AuthenticationScreen(
          role: SeenProfitsRole.business,
          page: AuthenticationPage.login,
        ),
    businessRegisterRouteName: (BuildContext context) =>
        const AuthenticationScreen(
          role: SeenProfitsRole.business,
          page: AuthenticationPage.register,
        ),
    businessOtpRouteName: (BuildContext context) => const AuthenticationScreen(
        role: SeenProfitsRole.business, page: AuthenticationPage.otp),
    businessForgotPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(
            role: SeenProfitsRole.business,
            page: AuthenticationPage.forgotPassword),
    businessResetPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(
            role: SeenProfitsRole.business,
            page: AuthenticationPage.resetPassword),
    businessHomeRouteName: (BuildContext context) => const BusinessHomeScreen(),
    businessDetailsRouteName: (BuildContext context) =>
        const InvestorBusinessDetailScreen(),
    chatRouteName: (BuildContext context) => const ChatScreen(),
    addBusinessRouteName: (BuildContext context) => const AddBusinessScreen(),
    verificationRouteName: (BuildContext context) => const VerificationScreen(),
    seekInvestmentRouteName: (BuildContext context) =>
        const SeekInvestmentScreen(),
    notificationsRouteName: (BuildContext context) =>
        const NotificationsScreen(),
    favoritesRouteName: (BuildContext context) => const FavoritesScreen(),
    profileSettingsRouteName: (BuildContext context) =>
        const InvestorProfileScreen(),
    businessRequestsRouteName: (BuildContext context) =>
        const BusinessRequestsScreen(),
    businessChatsRouteName: (BuildContext context) =>
        const BusinessChatListScreen(),
    businessProfileRouteName: (BuildContext context) =>
        const BusinessProfileSettingsScreen(),
    investorAuthRouteName: (BuildContext context) =>
        const AuthEntryScreen(role: SeenProfitsRole.investor),
    investorLoginRouteName: (BuildContext context) =>
        const AuthenticationScreen(
          role: SeenProfitsRole.investor,
          page: AuthenticationPage.login,
        ),
    investorRegisterRouteName: (BuildContext context) =>
        const AuthenticationScreen(
          role: SeenProfitsRole.investor,
          page: AuthenticationPage.register,
        ),
    investorOtpRouteName: (BuildContext context) => const AuthenticationScreen(
        role: SeenProfitsRole.investor, page: AuthenticationPage.otp),
    investorForgotPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(
            role: SeenProfitsRole.investor,
            page: AuthenticationPage.forgotPassword),
    investorResetPasswordRouteName: (BuildContext context) =>
        const AuthenticationScreen(
            role: SeenProfitsRole.investor,
            page: AuthenticationPage.resetPassword),
    investorHomeRouteName: (BuildContext context) => const InvestorHomeScreen(),
    investorRequestsRouteName: (BuildContext context) =>
        const InvestorRequestsScreen(),
    ratingsRouteName: (BuildContext context) => const RatingsReviewsScreen(),
    settingsRouteName: (BuildContext context) =>
        const SettingsScreen(business: false),
  };
}
