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

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Seen Profits'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Discover potential. Build prosperity.'**
  String get splashTagline;

  /// No description provided for @selectYourPath.
  ///
  /// In en, this message translates to:
  /// **'How would you like to use Seen Profits?'**
  String get selectYourPath;

  /// No description provided for @roleSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the path that best matches your goals. You can continue securely with a tailored experience.'**
  String get roleSelectionDescription;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @dukandar.
  ///
  /// In en, this message translates to:
  /// **'Dukandar'**
  String get dukandar;

  /// No description provided for @businessRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'List and grow your verified business with the right investors.'**
  String get businessRoleDescription;

  /// No description provided for @investor.
  ///
  /// In en, this message translates to:
  /// **'Investor'**
  String get investor;

  /// No description provided for @investorRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover verified local businesses and explore opportunities.'**
  String get investorRoleDescription;

  /// No description provided for @continueAsBusiness.
  ///
  /// In en, this message translates to:
  /// **'Continue as Business'**
  String get continueAsBusiness;

  /// No description provided for @continueAsInvestor.
  ///
  /// In en, this message translates to:
  /// **'Continue as Investor'**
  String get continueAsInvestor;

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

  /// No description provided for @welcomeBusiness.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Business Owner'**
  String get welcomeBusiness;

  /// No description provided for @welcomeInvestor.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Investor'**
  String get welcomeInvestor;

  /// No description provided for @welcomeToSeenProfits.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Seen Profits'**
  String get welcomeToSeenProfits;

  /// No description provided for @authenticationDescription.
  ///
  /// In en, this message translates to:
  /// **'Log in or create an account to continue securely.'**
  String get authenticationDescription;

  /// No description provided for @businessAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Access your business workspace or create a new account to start your verification journey.'**
  String get businessAuthDescription;

  /// No description provided for @investorAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to explore verified businesses or register to personalise your discovery experience.'**
  String get investorAuthDescription;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register;

  /// No description provided for @loginBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business login'**
  String get loginBusiness;

  /// No description provided for @registerBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business registration'**
  String get registerBusiness;

  /// No description provided for @loginInvestor.
  ///
  /// In en, this message translates to:
  /// **'Investor login'**
  String get loginInvestor;

  /// No description provided for @registerInvestor.
  ///
  /// In en, this message translates to:
  /// **'Investor registration'**
  String get registerInvestor;

  /// No description provided for @authPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'This screen is ready for the authentication UI in the next phase. No account or backend action is performed here.'**
  String get authPlaceholderMessage;

  /// No description provided for @backToWelcome.
  ///
  /// In en, this message translates to:
  /// **'Back to welcome'**
  String get backToWelcome;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or phone number'**
  String get emailOrPhone;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @cnic.
  ///
  /// In en, this message translates to:
  /// **'CNIC'**
  String get cnic;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createYourAccount;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number and we will help you reset your password.'**
  String get forgotPasswordDescription;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a new, secure password for your account.'**
  String get resetPasswordDescription;

  /// No description provided for @otpDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to {phoneNumber}.'**
  String otpDescription(Object phoneNumber);

  /// No description provided for @otpExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}s'**
  String otpExpiresIn(Object seconds);

  /// No description provided for @mockHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'You are all set'**
  String get mockHomeTitle;

  /// No description provided for @mockLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'You are signed in. Your workspace will be available in the next phase.'**
  String get mockLoginSuccess;

  /// No description provided for @mockVerificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your phone has been verified. Your workspace will be available in the next phase.'**
  String get mockVerificationSuccess;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully.'**
  String get passwordResetSuccess;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

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

  /// No description provided for @invalidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address or Pakistani phone number.'**
  String get invalidEmailOrPhone;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Pakistani phone number.'**
  String get invalidPhone;

  /// No description provided for @invalidCnic.
  ///
  /// In en, this message translates to:
  /// **'Enter CNIC as 12345-1234567-1.'**
  String get invalidCnic;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name using letters and spaces.'**
  String get invalidName;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters with a letter and a number.'**
  String get passwordRequirements;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatch;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter the complete 6-digit OTP.'**
  String get invalidOtp;

  /// No description provided for @registrationPrivacyHint.
  ///
  /// In en, this message translates to:
  /// **'Your CNIC and password stay on this device in this UI-only demo.'**
  String get registrationPrivacyHint;

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

  /// No description provided for @businessProfile.
  ///
  /// In en, this message translates to:
  /// **'Business profile'**
  String get businessProfile;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get businessName;

  /// No description provided for @abcGeneralStore.
  ///
  /// In en, this message translates to:
  /// **'ABC General Store'**
  String get abcGeneralStore;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @retail.
  ///
  /// In en, this message translates to:
  /// **'Retail'**
  String get retail;

  /// No description provided for @businessAge.
  ///
  /// In en, this message translates to:
  /// **'Business age'**
  String get businessAge;

  /// No description provided for @twoYears.
  ///
  /// In en, this message translates to:
  /// **'2 Years'**
  String get twoYears;

  /// No description provided for @threeYears.
  ///
  /// In en, this message translates to:
  /// **'3 Years'**
  String get threeYears;

  /// No description provided for @investmentRequired.
  ///
  /// In en, this message translates to:
  /// **'Investment required'**
  String get investmentRequired;

  /// No description provided for @rs100000.
  ///
  /// In en, this message translates to:
  /// **'Rs. 100,000'**
  String get rs100000;

  /// No description provided for @rs500000.
  ///
  /// In en, this message translates to:
  /// **'Rs. 500,000'**
  String get rs500000;

  /// No description provided for @verificationStatus.
  ///
  /// In en, this message translates to:
  /// **'Verification status'**
  String get verificationStatus;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @myBusiness.
  ///
  /// In en, this message translates to:
  /// **'My Business'**
  String get myBusiness;

  /// No description provided for @seekInvestment.
  ///
  /// In en, this message translates to:
  /// **'Seek Investment'**
  String get seekInvestment;

  /// No description provided for @investmentRequests.
  ///
  /// In en, this message translates to:
  /// **'Investment Requests'**
  String get investmentRequests;

  /// No description provided for @investorsConnections.
  ///
  /// In en, this message translates to:
  /// **'Investors / Connections'**
  String get investorsConnections;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @searchBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Search businesses'**
  String get searchBusinesses;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @foodRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Food & Restaurant'**
  String get foodRestaurant;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @featuredBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Featured businesses'**
  String get featuredBusinesses;

  /// No description provided for @xyzRestaurant.
  ///
  /// In en, this message translates to:
  /// **'XYZ Restaurant'**
  String get xyzRestaurant;

  /// No description provided for @lahore.
  ///
  /// In en, this message translates to:
  /// **'Lahore'**
  String get lahore;

  /// No description provided for @islamabad.
  ///
  /// In en, this message translates to:
  /// **'Islamabad'**
  String get islamabad;

  /// No description provided for @generalStoreDescription.
  ///
  /// In en, this message translates to:
  /// **'A trusted neighborhood store serving the local community.'**
  String get generalStoreDescription;

  /// No description provided for @restaurantDescription.
  ///
  /// In en, this message translates to:
  /// **'A growing restaurant with a passion for quality food.'**
  String get restaurantDescription;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business details'**
  String get businessDetails;

  /// No description provided for @businessOverview.
  ///
  /// In en, this message translates to:
  /// **'Business overview'**
  String get businessOverview;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @ratingValue.
  ///
  /// In en, this message translates to:
  /// **'4.8 / 5'**
  String get ratingValue;

  /// No description provided for @investmentPurpose.
  ///
  /// In en, this message translates to:
  /// **'Investment purpose'**
  String get investmentPurpose;

  /// No description provided for @inventoryExpansion.
  ///
  /// In en, this message translates to:
  /// **'Inventory expansion and new product lines.'**
  String get inventoryExpansion;

  /// No description provided for @performanceGraphPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Performance graph placeholder'**
  String get performanceGraphPlaceholder;

  /// No description provided for @invest.
  ///
  /// In en, this message translates to:
  /// **'Invest'**
  String get invest;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @investmentConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Investment request'**
  String get investmentConfirmation;

  /// No description provided for @staticInvestmentMessage.
  ///
  /// In en, this message translates to:
  /// **'Your investment interest has been recorded for this static demo.'**
  String get staticInvestmentMessage;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @chatWithBusiness.
  ///
  /// In en, this message translates to:
  /// **'Chat with ABC General Store'**
  String get chatWithBusiness;

  /// No description provided for @helloInvestor.
  ///
  /// In en, this message translates to:
  /// **'Hello! Thanks for reaching out.'**
  String get helloInvestor;

  /// No description provided for @thanksForYourInterest.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your interest in our business.'**
  String get thanksForYourInterest;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeMessage;
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
