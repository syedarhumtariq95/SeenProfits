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
