// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Seen Profits';

  @override
  String get splashTagline => 'Discover potential. Build prosperity.';

  @override
  String get selectYourPath => 'How would you like to use Seen Profits?';

  @override
  String get roleSelectionDescription =>
      'Choose the path that best matches your goals. You can continue securely with a tailored experience.';

  @override
  String get business => 'Business';

  @override
  String get dukandar => 'Dukandar';

  @override
  String get businessRoleDescription =>
      'List and grow your verified business with the right investors.';

  @override
  String get investor => 'Investor';

  @override
  String get investorRoleDescription =>
      'Discover verified local businesses and explore opportunities.';

  @override
  String get continueAsBusiness => 'Continue as Business';

  @override
  String get continueAsInvestor => 'Continue as Investor';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get urdu => 'Urdu';

  @override
  String get welcomeBusiness => 'Welcome, Business Owner';

  @override
  String get welcomeInvestor => 'Welcome, Investor';

  @override
  String get welcomeToSeenProfits => 'Welcome to Seen Profits';

  @override
  String get authenticationDescription =>
      'Log in or create an account to continue securely.';

  @override
  String get businessAuthDescription =>
      'Access your business workspace or create a new account to start your verification journey.';

  @override
  String get investorAuthDescription =>
      'Sign in to explore verified businesses or register to personalise your discovery experience.';

  @override
  String get login => 'Log in';

  @override
  String get register => 'Create account';

  @override
  String get loginBusiness => 'Business login';

  @override
  String get registerBusiness => 'Business registration';

  @override
  String get loginInvestor => 'Investor login';

  @override
  String get registerInvestor => 'Investor registration';

  @override
  String get authPlaceholderMessage =>
      'This screen is ready for the authentication UI in the next phase. No account or backend action is performed here.';

  @override
  String get backToWelcome => 'Back to welcome';

  @override
  String get fullName => 'Full name';

  @override
  String get email => 'Email';

  @override
  String get emailOrPhone => 'Email or phone number';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get cnic => 'CNIC';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get newPassword => 'New password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get continueLabel => 'Continue';

  @override
  String get verify => 'Verify';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get otp => 'OTP';

  @override
  String get createAccount => 'Create account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get createYourAccount => 'Create your account';

  @override
  String get forgotPasswordDescription =>
      'Enter your email or phone number and we will help you reset your password.';

  @override
  String get resetPasswordDescription =>
      'Choose a new, secure password for your account.';

  @override
  String otpDescription(Object phoneNumber) {
    return 'Enter the 6-digit code sent to $phoneNumber.';
  }

  @override
  String otpExpiresIn(Object seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get mockHomeTitle => 'You are all set';

  @override
  String get mockLoginSuccess =>
      'You are signed in. Your workspace will be available in the next phase.';

  @override
  String get mockVerificationSuccess =>
      'Your phone has been verified. Your workspace will be available in the next phase.';

  @override
  String get passwordResetSuccess =>
      'Your password has been reset successfully.';

  @override
  String get done => 'Done';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get invalidEmailOrPhone =>
      'Enter a valid email address or Pakistani phone number.';

  @override
  String get invalidPhone => 'Enter a valid Pakistani phone number.';

  @override
  String get invalidCnic => 'Enter CNIC as 12345-1234567-1.';

  @override
  String get invalidName => 'Enter your full name using letters and spaces.';

  @override
  String get passwordRequirements =>
      'Use at least 8 characters with a letter and a number.';

  @override
  String get passwordMismatch => 'Passwords do not match.';

  @override
  String get invalidOtp => 'Enter the complete 6-digit OTP.';

  @override
  String get registrationPrivacyHint =>
      'Your CNIC and password stay on this device in this UI-only demo.';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get businessProfile => 'Business profile';

  @override
  String get businessName => 'Business name';

  @override
  String get abcGeneralStore => 'ABC General Store';

  @override
  String get category => 'Category';

  @override
  String get retail => 'Retail';

  @override
  String get businessAge => 'Business age';

  @override
  String get twoYears => '2 Years';

  @override
  String get threeYears => '3 Years';

  @override
  String get investmentRequired => 'Investment required';

  @override
  String get rs100000 => 'Rs. 100,000';

  @override
  String get rs500000 => 'Rs. 500,000';

  @override
  String get verificationStatus => 'Verification status';

  @override
  String get verified => 'Verified';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get myBusiness => 'My Business';

  @override
  String get seekInvestment => 'Seek Investment';

  @override
  String get investmentRequests => 'Investment Requests';

  @override
  String get investorsConnections => 'Investors / Connections';

  @override
  String get chat => 'Chat';

  @override
  String get notifications => 'Notifications';

  @override
  String get searchBusinesses => 'Search businesses';

  @override
  String get all => 'All';

  @override
  String get foodRestaurant => 'Food & Restaurant';

  @override
  String get services => 'Services';

  @override
  String get featuredBusinesses => 'Featured businesses';

  @override
  String get xyzRestaurant => 'XYZ Restaurant';

  @override
  String get lahore => 'Lahore';

  @override
  String get islamabad => 'Islamabad';

  @override
  String get generalStoreDescription =>
      'A trusted neighborhood store serving the local community.';

  @override
  String get restaurantDescription =>
      'A growing restaurant with a passion for quality food.';

  @override
  String get businessDetails => 'Business details';

  @override
  String get businessOverview => 'Business overview';

  @override
  String get location => 'Location';

  @override
  String get rating => 'Rating';

  @override
  String get ratingValue => '4.8 / 5';

  @override
  String get investmentPurpose => 'Investment purpose';

  @override
  String get inventoryExpansion => 'Inventory expansion and new product lines.';

  @override
  String get performanceGraphPlaceholder => 'Performance graph placeholder';

  @override
  String get invest => 'Invest';

  @override
  String get connect => 'Connect';

  @override
  String get investmentConfirmation => 'Investment request';

  @override
  String get staticInvestmentMessage =>
      'Your investment interest has been recorded for this static demo.';

  @override
  String get close => 'Close';

  @override
  String get viewDetails => 'View details';

  @override
  String get chatWithBusiness => 'Chat with ABC General Store';

  @override
  String get helloInvestor => 'Hello! Thanks for reaching out.';

  @override
  String get thanksForYourInterest =>
      'Thanks for your interest in our business.';

  @override
  String get typeMessage => 'Type a message';
}
