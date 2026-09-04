// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'سین پرافٹس';

  @override
  String get splashTagline => 'صلاحیت دریافت کریں، خوشحالی بنائیں۔';

  @override
  String get selectYourPath => 'آپ سین پرافٹس کو کیسے استعمال کرنا چاہتے ہیں؟';

  @override
  String get roleSelectionDescription =>
      'اپنے مقصد کے مطابق راستہ منتخب کریں۔ آپ کے لیے مخصوص تجربے کے ساتھ آگے بڑھیں۔';

  @override
  String get business => 'کاروبار';

  @override
  String get dukandar => 'دکاندار';

  @override
  String get businessRoleDescription =>
      'صحیح سرمایہ کاروں کے ساتھ اپنے تصدیق شدہ کاروبار کو فہرست میں شامل کریں اور بڑھائیں۔';

  @override
  String get investor => 'سرمایہ کار';

  @override
  String get investorRoleDescription =>
      'تصدیق شدہ مقامی کاروبار دریافت کریں اور مواقع دیکھیں۔';

  @override
  String get continueAsBusiness => 'کاروبار کے طور پر جاری رکھیں';

  @override
  String get continueAsInvestor => 'سرمایہ کار کے طور پر جاری رکھیں';

  @override
  String get language => 'زبان';

  @override
  String get english => 'انگریزی';

  @override
  String get urdu => 'اردو';

  @override
  String get welcomeBusiness => 'خوش آمدید، کاروباری مالک';

  @override
  String get welcomeInvestor => 'خوش آمدید، سرمایہ کار';

  @override
  String get welcomeToSeenProfits => 'سین پرافٹس میں خوش آمدید';

  @override
  String get authenticationDescription =>
      'محفوظ طریقے سے جاری رکھنے کے لیے لاگ اِن کریں یا اکاؤنٹ بنائیں۔';

  @override
  String get businessAuthDescription =>
      'اپنے کاروباری ورک اسپیس میں داخل ہوں یا تصدیق کے سفر کے لیے نیا اکاؤنٹ بنائیں۔';

  @override
  String get investorAuthDescription =>
      'تصدیق شدہ کاروبار دیکھنے کے لیے سائن اِن کریں یا اپنی پسند کے مطابق دریافت کے لیے رجسٹر کریں۔';

  @override
  String get login => 'لاگ اِن';

  @override
  String get register => 'اکاؤنٹ بنائیں';

  @override
  String get loginBusiness => 'کاروباری لاگ اِن';

  @override
  String get registerBusiness => 'کاروباری رجسٹریشن';

  @override
  String get loginInvestor => 'سرمایہ کار لاگ اِن';

  @override
  String get registerInvestor => 'سرمایہ کار رجسٹریشن';

  @override
  String get authPlaceholderMessage =>
      'یہ اسکرین اگلے مرحلے میں تصدیق کے انٹرفیس کے لیے تیار ہے۔ یہاں کوئی اکاؤنٹ یا بیک اینڈ کارروائی نہیں ہوتی۔';

  @override
  String get backToWelcome => 'واپس خوش آمدید';

  @override
  String get fullName => 'پورا نام';

  @override
  String get email => 'ای میل';

  @override
  String get emailOrPhone => 'ای میل یا فون نمبر';

  @override
  String get phoneNumber => 'فون نمبر';

  @override
  String get cnic => 'شناختی کارڈ نمبر';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get confirmPassword => 'پاس ورڈ کی تصدیق';

  @override
  String get newPassword => 'نیا پاس ورڈ';

  @override
  String get forgotPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get resetPassword => 'پاس ورڈ تبدیل کریں';

  @override
  String get continueLabel => 'جاری رکھیں';

  @override
  String get verify => 'تصدیق کریں';

  @override
  String get resendOtp => 'او ٹی پی دوبارہ بھیجیں';

  @override
  String get otp => 'او ٹی پی';

  @override
  String get createAccount => 'اکاؤنٹ بنائیں';

  @override
  String get alreadyHaveAccount => 'پہلے سے اکاؤنٹ ہے؟';

  @override
  String get dontHaveAccount => 'اکاؤنٹ نہیں ہے؟';

  @override
  String get backToLogin => 'لاگ اِن پر واپس جائیں';

  @override
  String get signInToContinue => 'جاری رکھنے کے لیے لاگ اِن کریں';

  @override
  String get createYourAccount => 'اپنا اکاؤنٹ بنائیں';

  @override
  String get forgotPasswordDescription =>
      'اپنا ای میل یا فون نمبر درج کریں، ہم پاس ورڈ تبدیل کرنے میں مدد کریں گے۔';

  @override
  String get resetPasswordDescription =>
      'اپنے اکاؤنٹ کے لیے نیا اور محفوظ پاس ورڈ منتخب کریں۔';

  @override
  String otpDescription(Object phoneNumber) {
    return '$phoneNumber پر بھیجا گیا 6 ہندسوں کا کوڈ درج کریں۔';
  }

  @override
  String otpExpiresIn(Object seconds) {
    return 'کوڈ دوبارہ بھیجنے میں $seconds سیکنڈ';
  }

  @override
  String get mockHomeTitle => 'آپ تیار ہیں';

  @override
  String get mockLoginSuccess =>
      'آپ لاگ اِن ہو گئے ہیں۔ آپ کا ورک اسپیس اگلے مرحلے میں دستیاب ہوگا۔';

  @override
  String get mockVerificationSuccess =>
      'آپ کے فون کی تصدیق ہو گئی ہے۔ آپ کا ورک اسپیس اگلے مرحلے میں دستیاب ہوگا۔';

  @override
  String get passwordResetSuccess =>
      'آپ کا پاس ورڈ کامیابی سے تبدیل ہو گیا ہے۔';

  @override
  String get done => 'مکمل';

  @override
  String get requiredField => 'یہ خانہ ضروری ہے۔';

  @override
  String get invalidEmail => 'درست ای میل درج کریں۔';

  @override
  String get invalidEmailOrPhone =>
      'درست ای میل یا پاکستانی فون نمبر درج کریں۔';

  @override
  String get invalidPhone => 'درست پاکستانی فون نمبر درج کریں۔';

  @override
  String get invalidCnic => 'شناختی کارڈ 12345-1234567-1 کی صورت میں درج کریں۔';

  @override
  String get invalidName =>
      'اپنا پورا نام صرف حروف اور وقفوں کے ساتھ درج کریں۔';

  @override
  String get passwordRequirements =>
      'کم از کم 8 حروف، ایک حرف اور ایک عدد استعمال کریں۔';

  @override
  String get passwordMismatch => 'پاس ورڈ یکساں نہیں ہیں۔';

  @override
  String get invalidOtp => 'مکمل 6 ہندسوں کا او ٹی پی درج کریں۔';

  @override
  String get registrationPrivacyHint =>
      'اس صرف-UI ڈیمو میں آپ کا شناختی کارڈ اور پاس ورڈ اسی ڈیوائس پر رہتے ہیں۔';

  @override
  String get showPassword => 'پاس ورڈ دکھائیں';

  @override
  String get hidePassword => 'پاس ورڈ چھپائیں';

  @override
  String get businessProfile => 'کاروباری پروفائل';

  @override
  String get businessName => 'کاروبار کا نام';

  @override
  String get abcGeneralStore => 'اے بی سی جنرل اسٹور';

  @override
  String get category => 'زمرہ';

  @override
  String get retail => 'ریٹیل';

  @override
  String get businessAge => 'کاروبار کی عمر';

  @override
  String get twoYears => '2 سال';

  @override
  String get threeYears => '3 سال';

  @override
  String get investmentRequired => 'مطلوبہ سرمایہ';

  @override
  String get rs100000 => '100,000 روپے';

  @override
  String get rs500000 => '500,000 روپے';

  @override
  String get verificationStatus => 'تصدیقی حیثیت';

  @override
  String get verified => 'تصدیق شدہ';

  @override
  String get quickActions => 'فوری اقدامات';

  @override
  String get myBusiness => 'میرا کاروبار';

  @override
  String get seekInvestment => 'سرمایہ طلب کریں';

  @override
  String get investmentRequests => 'سرمایہ کاری کی درخواستیں';

  @override
  String get investorsConnections => 'سرمایہ کار / روابط';

  @override
  String get chat => 'چیٹ';

  @override
  String get notifications => 'اطلاعات';

  @override
  String get searchBusinesses => 'کاروبار تلاش کریں';

  @override
  String get all => 'تمام';

  @override
  String get foodRestaurant => 'کھانا اور ریسٹورنٹ';

  @override
  String get services => 'خدمات';

  @override
  String get featuredBusinesses => 'نمایاں کاروبار';

  @override
  String get xyzRestaurant => 'ایکس وائی زیڈ ریسٹورنٹ';

  @override
  String get lahore => 'لاہور';

  @override
  String get islamabad => 'اسلام آباد';

  @override
  String get generalStoreDescription =>
      'مقامی برادری کی خدمت کرنے والا قابل اعتماد اسٹور۔';

  @override
  String get restaurantDescription =>
      'معیاری کھانے کا شوق رکھنے والا ترقی کرتا ریسٹورنٹ۔';

  @override
  String get businessDetails => 'کاروبار کی تفصیلات';

  @override
  String get businessOverview => 'کاروباری جائزہ';

  @override
  String get location => 'مقام';

  @override
  String get rating => 'درجہ بندی';

  @override
  String get ratingValue => '4.8 / 5';

  @override
  String get investmentPurpose => 'سرمایہ کاری کا مقصد';

  @override
  String get inventoryExpansion => 'اسٹاک اور نئی مصنوعات میں توسیع۔';

  @override
  String get performanceGraphPlaceholder => 'کارکردگی گراف کی جگہ';

  @override
  String get invest => 'سرمایہ کاری';

  @override
  String get connect => 'رابطہ کریں';

  @override
  String get investmentConfirmation => 'سرمایہ کاری کی درخواست';

  @override
  String get staticInvestmentMessage =>
      'اس جامد ڈیمو میں آپ کی سرمایہ کاری کی دلچسپی محفوظ کر لی گئی ہے۔';

  @override
  String get close => 'بند کریں';

  @override
  String get viewDetails => 'تفصیلات دیکھیں';

  @override
  String get chatWithBusiness => 'اے بی سی جنرل اسٹور سے چیٹ';

  @override
  String get helloInvestor => 'السلام علیکم! رابطہ کرنے کا شکریہ۔';

  @override
  String get thanksForYourInterest => 'ہمارے کاروبار میں دلچسپی کا شکریہ۔';

  @override
  String get typeMessage => 'پیغام لکھیں';
}
