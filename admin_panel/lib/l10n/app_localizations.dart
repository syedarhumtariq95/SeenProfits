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

  /// No description provided for @noPendingVerifications.
  ///
  /// In en, this message translates to:
  /// **'No pending verification requests.'**
  String get noPendingVerifications;

  /// No description provided for @cnicLabel.
  ///
  /// In en, this message translates to:
  /// **'CNIC'**
  String get cnicLabel;

  /// No description provided for @documentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsLabel;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approveBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve business?'**
  String get approveBusinessTitle;

  /// No description provided for @approveBusinessMessage.
  ///
  /// In en, this message translates to:
  /// **'Approve {business} for verification?'**
  String approveBusinessMessage(String business);

  /// No description provided for @rejectBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject business?'**
  String get rejectBusinessTitle;

  /// No description provided for @rejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason'**
  String get rejectionReason;

  /// No description provided for @verificationActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification request processed successfully.'**
  String get verificationActionSuccess;

  /// No description provided for @verificationActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to process verification request. Please try again.'**
  String get verificationActionFailed;

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

  /// No description provided for @searchBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Search businesses'**
  String get searchBusinesses;

  /// No description provided for @businessStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get businessStatus;

  /// No description provided for @allStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get allStatuses;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get suspended;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get businessName;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @viewBusiness.
  ///
  /// In en, this message translates to:
  /// **'View business'**
  String get viewBusiness;

  /// No description provided for @editBusiness.
  ///
  /// In en, this message translates to:
  /// **'Edit business'**
  String get editBusiness;

  /// No description provided for @noBusinessesFound.
  ///
  /// In en, this message translates to:
  /// **'No businesses match your filters.'**
  String get noBusinessesFound;

  /// No description provided for @businessActionSelected.
  ///
  /// In en, this message translates to:
  /// **'{action} selected for {business}'**
  String businessActionSelected(String action, String business);

  /// No description provided for @businessRecordAlpha.
  ///
  /// In en, this message translates to:
  /// **'Alpha Foods'**
  String get businessRecordAlpha;

  /// No description provided for @businessRecordVertex.
  ///
  /// In en, this message translates to:
  /// **'Vertex Solutions'**
  String get businessRecordVertex;

  /// No description provided for @businessRecordGreenfield.
  ///
  /// In en, this message translates to:
  /// **'Greenfield Farms'**
  String get businessRecordGreenfield;

  /// No description provided for @businessRecordAtlas.
  ///
  /// In en, this message translates to:
  /// **'Atlas Textiles'**
  String get businessRecordAtlas;

  /// No description provided for @businessOwnerAyesha.
  ///
  /// In en, this message translates to:
  /// **'Ayesha Khan'**
  String get businessOwnerAyesha;

  /// No description provided for @businessOwnerBilal.
  ///
  /// In en, this message translates to:
  /// **'Bilal Ahmed'**
  String get businessOwnerBilal;

  /// No description provided for @businessOwnerFatima.
  ///
  /// In en, this message translates to:
  /// **'Fatima Noor'**
  String get businessOwnerFatima;

  /// No description provided for @businessOwnerHamza.
  ///
  /// In en, this message translates to:
  /// **'Hamza Ali'**
  String get businessOwnerHamza;

  /// No description provided for @foodAndBeverage.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverage'**
  String get foodAndBeverage;

  /// No description provided for @technology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get technology;

  /// No description provided for @agriculture.
  ///
  /// In en, this message translates to:
  /// **'Agriculture'**
  String get agriculture;

  /// No description provided for @manufacturing.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing'**
  String get manufacturing;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business details'**
  String get businessDetails;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @assignedPlan.
  ///
  /// In en, this message translates to:
  /// **'Assigned tier / plan'**
  String get assignedPlan;

  /// No description provided for @starterPlan.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get starterPlan;

  /// No description provided for @growthPlan.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get growthPlan;

  /// No description provided for @enterprisePlan.
  ///
  /// In en, this message translates to:
  /// **'Enterprise'**
  String get enterprisePlan;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @businessUpdated.
  ///
  /// In en, this message translates to:
  /// **'Business details updated.'**
  String get businessUpdated;

  /// No description provided for @businessUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update business details. Please try again.'**
  String get businessUpdateFailed;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @activeBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Active Businesses'**
  String get activeBusinesses;

  /// No description provided for @pendingBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Pending Businesses'**
  String get pendingBusinesses;

  /// No description provided for @suspendedBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Suspended Businesses'**
  String get suspendedBusinesses;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @monthlyGrowth.
  ///
  /// In en, this message translates to:
  /// **'Monthly Growth'**
  String get monthlyGrowth;

  /// No description provided for @refreshDashboard.
  ///
  /// In en, this message translates to:
  /// **'Refresh dashboard'**
  String get refreshDashboard;

  /// No description provided for @dashboardLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load dashboard data. Please try again.'**
  String get dashboardLoadFailed;

  /// No description provided for @businessApprovedActivity.
  ///
  /// In en, this message translates to:
  /// **'Approved business: {name}'**
  String businessApprovedActivity(String name);

  /// No description provided for @businessSubmittedActivity.
  ///
  /// In en, this message translates to:
  /// **'New business submitted: {name}'**
  String businessSubmittedActivity(String name);

  /// No description provided for @businessSuspendedActivity.
  ///
  /// In en, this message translates to:
  /// **'Suspended business: {name}'**
  String businessSuspendedActivity(String name);

  /// No description provided for @revenueReceivedActivity.
  ///
  /// In en, this message translates to:
  /// **'Revenue received: {amount}'**
  String revenueReceivedActivity(String amount);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(int minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(int hours);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @userManagement.
  ///
  /// In en, this message translates to:
  /// **'User management'**
  String get userManagement;

  /// No description provided for @searchUsers.
  ///
  /// In en, this message translates to:
  /// **'Search users'**
  String get searchUsers;

  /// No description provided for @userRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get userRole;

  /// No description provided for @allUsers.
  ///
  /// In en, this message translates to:
  /// **'All users'**
  String get allUsers;

  /// No description provided for @investor.
  ///
  /// In en, this message translates to:
  /// **'Investor'**
  String get investor;

  /// No description provided for @businessOwner.
  ///
  /// In en, this message translates to:
  /// **'Business owner'**
  String get businessOwner;

  /// No description provided for @userStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get userStatus;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @userDetails.
  ///
  /// In en, this message translates to:
  /// **'User details'**
  String get userDetails;

  /// No description provided for @viewUser.
  ///
  /// In en, this message translates to:
  /// **'View user'**
  String get viewUser;

  /// No description provided for @suspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get suspend;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @changeUserStatus.
  ///
  /// In en, this message translates to:
  /// **'Change user status'**
  String get changeUserStatus;

  /// No description provided for @changeUserStatusMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to {action} {name}?'**
  String changeUserStatusMessage(String name, String action);

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users match your filters.'**
  String get noUsersFound;

  /// No description provided for @searchDeals.
  ///
  /// In en, this message translates to:
  /// **'Search businesses or investors'**
  String get searchDeals;

  /// No description provided for @dealStatus.
  ///
  /// In en, this message translates to:
  /// **'Deal status'**
  String get dealStatus;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @dealDetails.
  ///
  /// In en, this message translates to:
  /// **'Deal details'**
  String get dealDetails;

  /// No description provided for @investmentAmount.
  ///
  /// In en, this message translates to:
  /// **'Investment amount'**
  String get investmentAmount;

  /// No description provided for @expectedReturn.
  ///
  /// In en, this message translates to:
  /// **'Expected return'**
  String get expectedReturn;

  /// No description provided for @viewDeal.
  ///
  /// In en, this message translates to:
  /// **'View deal'**
  String get viewDeal;

  /// No description provided for @noDealsFound.
  ///
  /// In en, this message translates to:
  /// **'No deals match your filters.'**
  String get noDealsFound;

  /// No description provided for @approveProposalTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve proposal?'**
  String get approveProposalTitle;

  /// No description provided for @approveProposalMessage.
  ///
  /// In en, this message translates to:
  /// **'Approve the investment proposal for {business}?'**
  String approveProposalMessage(String business);

  /// No description provided for @rejectProposalTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject proposal?'**
  String get rejectProposalTitle;

  /// No description provided for @rejectProposalMessage.
  ///
  /// In en, this message translates to:
  /// **'Reject the investment proposal for {business}?'**
  String rejectProposalMessage(String business);

  /// No description provided for @dealActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deal proposal updated successfully.'**
  String get dealActionSuccess;

  /// No description provided for @dealActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update deal proposal. Please try again.'**
  String get dealActionFailed;

  /// No description provided for @profitDistribution.
  ///
  /// In en, this message translates to:
  /// **'Profit Distribution'**
  String get profitDistribution;

  /// No description provided for @totalProfit.
  ///
  /// In en, this message translates to:
  /// **'Total profit'**
  String get totalProfit;

  /// No description provided for @investorPayouts.
  ///
  /// In en, this message translates to:
  /// **'Investor payouts'**
  String get investorPayouts;

  /// No description provided for @pendingPayouts.
  ///
  /// In en, this message translates to:
  /// **'Pending payouts'**
  String get pendingPayouts;

  /// No description provided for @searchProfitDistributions.
  ///
  /// In en, this message translates to:
  /// **'Search businesses or investors'**
  String get searchProfitDistributions;

  /// No description provided for @payoutStatus.
  ///
  /// In en, this message translates to:
  /// **'Payout status'**
  String get payoutStatus;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @investorYield.
  ///
  /// In en, this message translates to:
  /// **'Investor yield'**
  String get investorYield;

  /// No description provided for @distributionDate.
  ///
  /// In en, this message translates to:
  /// **'Distribution date'**
  String get distributionDate;

  /// No description provided for @triggerPayout.
  ///
  /// In en, this message translates to:
  /// **'Trigger payout'**
  String get triggerPayout;

  /// No description provided for @retryPayout.
  ///
  /// In en, this message translates to:
  /// **'Retry payout'**
  String get retryPayout;

  /// No description provided for @triggerPayoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Trigger payout?'**
  String get triggerPayoutTitle;

  /// No description provided for @triggerPayoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Start the payout process for {investor}?'**
  String triggerPayoutMessage(String investor);

  /// No description provided for @noProfitDistributions.
  ///
  /// In en, this message translates to:
  /// **'No profit distributions match your filters.'**
  String get noProfitDistributions;

  /// No description provided for @profitLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load profit distributions. Please try again.'**
  String get profitLoadFailed;

  /// No description provided for @payoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update the payout. Please try again.'**
  String get payoutFailed;

  /// No description provided for @reportsAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Reports & Analytics'**
  String get reportsAnalytics;

  /// No description provided for @platformVolume.
  ///
  /// In en, this message translates to:
  /// **'Platform volume'**
  String get platformVolume;

  /// No description provided for @dealSuccessRate.
  ///
  /// In en, this message translates to:
  /// **'Deal success rate'**
  String get dealSuccessRate;

  /// No description provided for @totalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total users'**
  String get totalUsers;

  /// No description provided for @newUsers.
  ///
  /// In en, this message translates to:
  /// **'New users'**
  String get newUsers;

  /// No description provided for @platformRevenue.
  ///
  /// In en, this message translates to:
  /// **'Platform revenue'**
  String get platformRevenue;

  /// No description provided for @volumeTrend.
  ///
  /// In en, this message translates to:
  /// **'Platform volume trend'**
  String get volumeTrend;

  /// No description provided for @userGrowth.
  ///
  /// In en, this message translates to:
  /// **'User growth'**
  String get userGrowth;

  /// No description provided for @revenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue trend'**
  String get revenueTrend;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select date range'**
  String get selectDateRange;

  /// No description provided for @exportReport.
  ///
  /// In en, this message translates to:
  /// **'Export report'**
  String get exportReport;

  /// No description provided for @chooseExportFormat.
  ///
  /// In en, this message translates to:
  /// **'Choose an export format.'**
  String get chooseExportFormat;

  /// No description provided for @reportExported.
  ///
  /// In en, this message translates to:
  /// **'Report generated: {fileName}'**
  String reportExported(String fileName);

  /// No description provided for @reportsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load analytics data. Please try again.'**
  String get reportsLoadFailed;

  /// No description provided for @searchCategories.
  ///
  /// In en, this message translates to:
  /// **'Search categories'**
  String get searchCategories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get editCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get deleteCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @categoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get categoryDescription;

  /// No description provided for @categoryIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon name'**
  String get categoryIcon;

  /// No description provided for @categoryStatus.
  ///
  /// In en, this message translates to:
  /// **'Category status'**
  String get categoryStatus;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @businessesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} businesses'**
  String businessesCount(int count);

  /// No description provided for @categoryActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully.'**
  String get categoryActionSuccess;

  /// No description provided for @categoryActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update category. Please try again.'**
  String get categoryActionFailed;

  /// No description provided for @categoriesLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load categories. Please try again.'**
  String get categoriesLoadFailed;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories match your search.'**
  String get noCategoriesFound;

  /// No description provided for @totalNotifications.
  ///
  /// In en, this message translates to:
  /// **'Total notifications'**
  String get totalNotifications;

  /// No description provided for @sentNotifications.
  ///
  /// In en, this message translates to:
  /// **'Sent notifications'**
  String get sentNotifications;

  /// No description provided for @totalRecipients.
  ///
  /// In en, this message translates to:
  /// **'Total recipients'**
  String get totalRecipients;

  /// No description provided for @broadcastNotification.
  ///
  /// In en, this message translates to:
  /// **'Broadcast notification'**
  String get broadcastNotification;

  /// No description provided for @searchNotifications.
  ///
  /// In en, this message translates to:
  /// **'Search notifications'**
  String get searchNotifications;

  /// No description provided for @recipientAudience.
  ///
  /// In en, this message translates to:
  /// **'Recipient audience'**
  String get recipientAudience;

  /// No description provided for @allRecipients.
  ///
  /// In en, this message translates to:
  /// **'All recipients'**
  String get allRecipients;

  /// No description provided for @notificationStatus.
  ///
  /// In en, this message translates to:
  /// **'Notification status'**
  String get notificationStatus;

  /// No description provided for @notificationSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get notificationSent;

  /// No description provided for @notificationPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get notificationPending;

  /// No description provided for @notificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get notificationFailed;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get notificationTitle;

  /// No description provided for @notificationMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get notificationMessage;

  /// No description provided for @sendNotification.
  ///
  /// In en, this message translates to:
  /// **'Send notification'**
  String get sendNotification;

  /// No description provided for @recipients.
  ///
  /// In en, this message translates to:
  /// **'recipients'**
  String get recipients;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @noNotificationsFound.
  ///
  /// In en, this message translates to:
  /// **'No notifications match your filters.'**
  String get noNotificationsFound;

  /// No description provided for @notificationsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load notifications. Please try again.'**
  String get notificationsLoadFailed;

  /// No description provided for @notificationActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to send the notification. Please try again.'**
  String get notificationActionFailed;
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
