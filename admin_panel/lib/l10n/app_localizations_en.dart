// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get toggleSidebar => 'Toggle sidebar';

  @override
  String get businessManagement => 'Business Management';

  @override
  String get verificationQueue => 'Verification Queue';

  @override
  String get investorManagement => 'Investor Management';

  @override
  String get reportsAndComplaints => 'Reports & Complaints';

  @override
  String get systemAuditLogs => 'System / Audit Logs';

  @override
  String get adminSettings => 'Admin Settings';

  @override
  String get profile => 'Profile';

  @override
  String get profileSettings => 'Profile & Settings';

  @override
  String get notificationsPlaceholder => 'Notifications';

  @override
  String get logoutConfirmationTitle => 'Sign out?';

  @override
  String get logoutConfirmationMessage =>
      'You will be returned to the admin login screen.';

  @override
  String get cancel => 'Cancel';

  @override
  String get totalBusinesses => 'Total Businesses';

  @override
  String get pendingVerifications => 'Pending Verifications';

  @override
  String get activeInvestors => 'Active Investors';

  @override
  String get totalInvestmentRequests => 'Total Investment Requests';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get recentActivityPlaceholder =>
      'Recent platform activity will appear here in a later phase.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get reviewPendingBusiness => 'Review Pending Business';

  @override
  String get viewReports => 'View Reports';

  @override
  String get mockDashboardDataNotice =>
      'Static layout preview — no live data is connected.';

  @override
  String get verificationOfficer => 'Verification Officer';

  @override
  String get supportModerator => 'Support / Moderator';

  @override
  String get analyst => 'Analyst';

  @override
  String get appName => 'Seen Profits Admin';

  @override
  String get adminPortal => 'Administration portal';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get businesses => 'Businesses';

  @override
  String get verification => 'Verification';

  @override
  String get investors => 'Investors';

  @override
  String get businessOwners => 'Business Owners';

  @override
  String get investmentRequests => 'Investment Requests';

  @override
  String get reports => 'Reports';

  @override
  String get categories => 'Categories';

  @override
  String get notifications => 'Notifications';

  @override
  String get content => 'Content';

  @override
  String get analytics => 'Analytics';

  @override
  String get auditLogs => 'Audit Logs';

  @override
  String get adminAccounts => 'Admin Accounts';

  @override
  String get settings => 'Settings';

  @override
  String get login => 'Login';

  @override
  String get twoFactorAuthentication => 'Two-factor authentication';

  @override
  String get loginPlaceholderTitle => 'Admin login';

  @override
  String get loginPlaceholderDescription =>
      'Authentication will be connected in a later phase.';

  @override
  String get twoFactorPlaceholderTitle => 'Two-factor authentication';

  @override
  String get twoFactorPlaceholderDescription =>
      'Two-factor verification will be connected in a later phase.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get comingSoon => 'Coming in the next phase';

  @override
  String get comingSoonDescription =>
      'This section is ready for its feature implementation.';

  @override
  String get dashboardPlaceholderTitle => 'Dashboard foundation ready';

  @override
  String get dashboardPlaceholderDescription =>
      'The admin shell and routing are ready. Dashboard data will be added in a later phase.';

  @override
  String get menu => 'Menu';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get urdu => 'Urdu';

  @override
  String get administrator => 'Administrator';

  @override
  String get superAdmin => 'Super Admin';

  @override
  String get signOut => 'Sign out';

  @override
  String get openNavigation => 'Open navigation';

  @override
  String get closeNavigation => 'Close navigation';

  @override
  String get adminLoginTitle => 'Admin Login';

  @override
  String get adminLoginDescription =>
      'Sign in to access the Seen Profits administration portal.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get invalidCredentials =>
      'The email or password is not valid for this mock environment.';

  @override
  String get invalidVerificationCode =>
      'Enter the valid 6-digit verification code.';

  @override
  String get enterVerificationCodeDescription =>
      'Enter the 6-digit verification code to continue.';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String resendCodeIn(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get backToLogin => 'Back to login';

  @override
  String get submit => 'Submit';

  @override
  String get forgotPasswordDescription =>
      'Enter your email address and we will simulate a password-reset request.';

  @override
  String get passwordResetMockSuccess =>
      'Mock reset request sent. No email is delivered in this development-only flow.';

  @override
  String get mockLoginHint =>
      'Development mock: use admin@demo.local and DemoAdmin123!';

  @override
  String get mockTwoFactorHint => 'Development mock code: 123456';

  @override
  String get mockCodeResent =>
      'Mock verification code resent. Use the development code shown below.';

  @override
  String get signingIn => 'Signing in';

  @override
  String get verifyingCode => 'Verifying code';

  @override
  String get sendingResetRequest => 'Sending reset request';

  @override
  String get loginSuccessful => 'Login successful';
}
