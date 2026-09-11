import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
  ];

  /// No description provided for @toggleSidebar.
  ///
  /// In en, this message translates to:
  /// **'Toggle sidebar'**
  String get toggleSidebar;

  /// No description provided for @businessManagement.
  ///
  /// In en, this message translates to:
  /// **'Business Management'**
  String get businessManagement;

  /// No description provided for @verificationQueue.
  ///
  /// In en, this message translates to:
  /// **'Verification Queue'**
  String get verificationQueue;

  /// No description provided for @investorManagement.
  ///
  /// In en, this message translates to:
  /// **'Investor Management'**
  String get investorManagement;

  /// No description provided for @reportsAndComplaints.
  ///
  /// In en, this message translates to:
  /// **'Reports & Complaints'**
  String get reportsAndComplaints;

  /// No description provided for @systemAuditLogs.
  ///
  /// In en, this message translates to:
  /// **'System / Audit Logs'**
  String get systemAuditLogs;

  /// No description provided for @adminSettings.
  ///
  /// In en, this message translates to:
  /// **'Admin Settings'**
  String get adminSettings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile & Settings'**
  String get profileSettings;

  /// No description provided for @notificationsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsPlaceholder;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'You will be returned to the admin login screen.'**
  String get logoutConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @totalBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Total Businesses'**
  String get totalBusinesses;

  /// No description provided for @pendingVerifications.
  ///
  /// In en, this message translates to:
  /// **'Pending Verifications'**
  String get pendingVerifications;

  /// No description provided for @activeInvestors.
  ///
  /// In en, this message translates to:
  /// **'Active Investors'**
  String get activeInvestors;

  /// No description provided for @totalInvestmentRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Investment Requests'**
  String get totalInvestmentRequests;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @recentActivityPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Recent platform activity will appear here in a later phase.'**
  String get recentActivityPlaceholder;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @reviewPendingBusiness.
  ///
  /// In en, this message translates to:
  /// **'Review Pending Business'**
  String get reviewPendingBusiness;

  /// No description provided for @viewReports.
  ///
  /// In en, this message translates to:
  /// **'View Reports'**
  String get viewReports;

  /// No description provided for @mockDashboardDataNotice.
  ///
  /// In en, this message translates to:
  /// **'Static layout preview — no live data is connected.'**
  String get mockDashboardDataNotice;

  /// No description provided for @verificationOfficer.
  ///
  /// In en, this message translates to:
  /// **'Verification Officer'**
  String get verificationOfficer;

  /// No description provided for @supportModerator.
  ///
  /// In en, this message translates to:
  /// **'Support / Moderator'**
  String get supportModerator;

  /// No description provided for @analyst.
  ///
  /// In en, this message translates to:
  /// **'Analyst'**
  String get analyst;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Seen Profits Admin'**
  String get appName;

  /// No description provided for @adminPortal.
  ///
  /// In en, this message translates to:
  /// **'Administration portal'**
  String get adminPortal;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @businesses.
  ///
  /// In en, this message translates to:
  /// **'Businesses'**
  String get businesses;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @investors.
  ///
  /// In en, this message translates to:
  /// **'Investors'**
  String get investors;

  /// No description provided for @businessOwners.
  ///
  /// In en, this message translates to:
  /// **'Business Owners'**
  String get businessOwners;

  /// No description provided for @investmentRequests.
  ///
  /// In en, this message translates to:
  /// **'Investment Requests'**
  String get investmentRequests;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @auditLogs.
  ///
  /// In en, this message translates to:
  /// **'Audit Logs'**
  String get auditLogs;

  /// No description provided for @adminAccounts.
  ///
  /// In en, this message translates to:
  /// **'Admin Accounts'**
  String get adminAccounts;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @twoFactorAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get twoFactorAuthentication;

  /// No description provided for @loginPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin login'**
  String get loginPlaceholderTitle;

  /// No description provided for @loginPlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'Authentication will be connected in a later phase.'**
  String get loginPlaceholderDescription;

  /// No description provided for @twoFactorPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get twoFactorPlaceholderTitle;

  /// No description provided for @twoFactorPlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'Two-factor verification will be connected in a later phase.'**
  String get twoFactorPlaceholderDescription;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming in the next phase'**
  String get comingSoon;

  /// No description provided for @comingSoonDescription.
  ///
  /// In en, this message translates to:
  /// **'This section is ready for its feature implementation.'**
  String get comingSoonDescription;

  /// No description provided for @dashboardPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard foundation ready'**
  String get dashboardPlaceholderTitle;

  /// No description provided for @dashboardPlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'The admin shell and routing are ready. Dashboard data will be added in a later phase.'**
  String get dashboardPlaceholderDescription;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get administrator;

  /// No description provided for @superAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super Admin'**
  String get superAdmin;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @openNavigation.
  ///
  /// In en, this message translates to:
  /// **'Open navigation'**
  String get openNavigation;

  /// No description provided for @closeNavigation.
  ///
  /// In en, this message translates to:
  /// **'Close navigation'**
  String get closeNavigation;

  /// No description provided for @adminLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Login'**
  String get adminLoginTitle;

  /// No description provided for @adminLoginDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access the Seen Profits administration portal.'**
  String get adminLoginDescription;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'The email or password is not valid for this mock environment.'**
  String get invalidCredentials;

  /// No description provided for @invalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the valid 6-digit verification code.'**
  String get invalidVerificationCode;

  /// No description provided for @enterVerificationCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit verification code to continue.'**
  String get enterVerificationCodeDescription;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}s'**
  String resendCodeIn(int seconds);

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will simulate a password-reset request.'**
  String get forgotPasswordDescription;

  /// No description provided for @passwordResetMockSuccess.
  ///
  /// In en, this message translates to:
  /// **'Mock reset request sent. No email is delivered in this development-only flow.'**
  String get passwordResetMockSuccess;

  /// No description provided for @mockLoginHint.
  ///
  /// In en, this message translates to:
  /// **'Development mock: use admin@demo.local and DemoAdmin123!'**
  String get mockLoginHint;

  /// No description provided for @mockTwoFactorHint.
  ///
  /// In en, this message translates to:
  /// **'Development mock code: 123456'**
  String get mockTwoFactorHint;

  /// No description provided for @mockCodeResent.
  ///
  /// In en, this message translates to:
  /// **'Mock verification code resent. Use the development code shown below.'**
  String get mockCodeResent;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in'**
  String get signingIn;

  /// No description provided for @verifyingCode.
  ///
  /// In en, this message translates to:
  /// **'Verifying code'**
  String get verifyingCode;

  /// No description provided for @sendingResetRequest.
  ///
  /// In en, this message translates to:
  /// **'Sending reset request'**
  String get sendingResetRequest;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
