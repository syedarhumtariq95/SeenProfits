import 'package:seen_profits/l10n/app_localizations.dart';
import 'package:seen_profits/l10n/app_localizations_ur.dart';

extension HomeLocalizations on AppLocalizations {
  String _t(String en, String ur) => this is AppLocalizationsUr ? ur : en;
  String get businessProfile => _t('Business profile', 'کاروباری پروفائل');
  String get businessName => _t('Business name', 'کاروبار کا نام');
  String get abcGeneralStore => _t('ABC General Store', 'اے بی سی جنرل اسٹور');
  String get category => _t('Category', 'زمرہ');
  String get retail => _t('Retail', 'ریٹیل');
  String get businessAge => _t('Business age', 'کاروبار کی عمر');
  String get twoYears => _t('2 Years', '2 سال');
  String get threeYears => _t('3 Years', '3 سال');
  String get investmentRequired => _t('Investment required', 'مطلوبہ سرمایہ');
  String get rs100000 => _t('Rs. 100,000', '100,000 روپے');
  String get rs500000 => _t('Rs. 500,000', '500,000 روپے');
  String get verificationStatus => _t('Verification status', 'تصدیقی حیثیت');
  String get verified => _t('Verified', 'تصدیق شدہ');
  String get quickActions => _t('Quick actions', 'فوری اقدامات');
  String get myBusiness => _t('My Business', 'میرا کاروبار');
  String get seekInvestment => _t('Seek Investment', 'سرمایہ طلب کریں');
  String get investmentRequests =>
      _t('Investment Requests', 'سرمایہ کاری کی درخواستیں');
  String get investorsConnections =>
      _t('Investors / Connections', 'سرمایہ کار / روابط');
  String get chat => _t('Chat', 'چیٹ');
  String get notifications => _t('Notifications', 'اطلاعات');
  String get searchBusinesses => _t('Search businesses', 'کاروبار تلاش کریں');
  String get all => _t('All', 'تمام');
  String get foodRestaurant => _t('Food & Restaurant', 'کھانا اور ریسٹورنٹ');
  String get services => _t('Services', 'خدمات');
  String get featuredBusinesses => _t('Featured businesses', 'نمایاں کاروبار');
  String get xyzRestaurant => _t('XYZ Restaurant', 'ایکس وائی زیڈ ریسٹورنٹ');
  String get lahore => _t('Lahore', 'لاہور');
  String get islamabad => _t('Islamabad', 'اسلام آباد');
  String get generalStoreDescription => _t(
      'A trusted neighborhood store serving the local community.',
      'مقامی برادری کی خدمت کرنے والا قابل اعتماد اسٹور۔');
  String get restaurantDescription => _t(
      'A growing restaurant with a passion for quality food.',
      'معیاری کھانے کا شوق رکھنے والا ترقی کرتا ریسٹورنٹ۔');
  String get businessDetails => _t('Business details', 'کاروبار کی تفصیلات');
  String get businessOverview => _t('Business overview', 'کاروباری جائزہ');
  String get location => _t('Location', 'مقام');
  String get rating => _t('Rating', 'درجہ بندی');
  String get ratingValue => '4.8 / 5';
  String get investmentPurpose =>
      _t('Investment purpose', 'سرمایہ کاری کا مقصد');
  String get inventoryExpansion => _t(
      'Inventory expansion and new product lines.',
      'اسٹاک اور نئی مصنوعات میں توسیع۔');
  String get performanceGraphPlaceholder =>
      _t('Performance graph placeholder', 'کارکردگی گراف کی جگہ');
  String get invest => _t('Invest', 'سرمایہ کاری');
  String get connect => _t('Connect', 'رابطہ کریں');
  String get investmentConfirmation =>
      _t('Investment request', 'سرمایہ کاری کی درخواست');
  String get staticInvestmentMessage => _t(
      'Your investment interest has been recorded for this static demo.',
      'اس جامد ڈیمو میں آپ کی سرمایہ کاری کی دلچسپی محفوظ کر لی گئی ہے۔');
  String get close => _t('Close', 'بند کریں');
  String get viewDetails => _t('View details', 'تفصیلات دیکھیں');
  String get chatWithBusiness =>
      _t('Chat with ABC General Store', 'اے بی سی جنرل اسٹور سے چیٹ');
  String get helloInvestor => _t(
      'Hello! Thanks for reaching out.', 'السلام علیکم! رابطہ کرنے کا شکریہ۔');
  String get thanksForYourInterest => _t(
      'Thanks for your interest in our business.',
      'ہمارے کاروبار میں دلچسپی کا شکریہ۔');
  String get typeMessage => _t('Type a message', 'پیغام لکھیں');
  String get addBusiness=>_t('Add Business','کاروبار شامل کریں'); String get step=>_t('Step','مرحلہ'); String get ofLabel=>_t('of','از'); String get next=>_t('Next','اگلا'); String get submitForVerification=>_t('Submit for verification','تصدیق کے لیے جمع کریں'); String get privateDocuments=>_t('Private verification documents','نجی تصدیقی دستاویزات'); String get submittedForReview=>_t('Submitted for review','جائزے کے لیے جمع کر دیا گیا'); String get verificationWorkflow=>_t('Verification workflow','تصدیقی مراحل'); String get pending=>_t('Pending verification','تصدیق زیر التوا'); String get approved=>_t('Approved','منظور شدہ'); String get rejected=>_t('Rejected','مسترد'); String get changesRequired=>_t('Changes required','تبدیلیاں مطلوب'); String get suspended=>_t('Suspended','معطل'); String get statusExplanation=>_t('Your listing status and next steps appear here.','آپ کی فہرست کی حیثیت اور اگلے مراحل یہاں دکھائے جاتے ہیں۔'); String get requiredAmount=>_t('Required investment amount','مطلوبہ سرمایہ کاری'); String get businessExpansion=>_t('Business expansion','کاروباری توسیع'); String get equipment=>_t('Equipment','آلات'); String get proposedTerms=>_t('Proposed terms (TBD)','مجوزہ شرائط (TBD)'); String get discoveryDisclaimer=>_t('Seen Profits is a discovery and connection platform. It does not guarantee returns or move money.','سین منافع دریافت اور رابطے کا پلیٹ فارم ہے۔ یہ منافع کی ضمانت یا رقم کی منتقلی نہیں کرتا۔'); String get submitOpportunity=>_t('Submit opportunity','موقع جمع کریں'); String get opportunitySubmitted=>_t('Opportunity submitted','موقع جمع ہو گیا'); String get staticMockStatus=>_t('This static opportunity is now open for interest.','یہ جامد موقع اب دلچسپی کے لیے کھلا ہے۔'); String get verificationApprovedNotification=>_t('Your business verification was approved.','آپ کے کاروبار کی تصدیق منظور ہو گئی۔'); String get investmentInterestNotification=>_t('An investor expressed interest in your business.','ایک سرمایہ کار نے آپ کے کاروبار میں دلچسپی ظاہر کی۔'); String get newMessageNotification=>_t('You have a new message.','آپ کے لیے نیا پیغام ہے۔'); String get today=>_t('Today','آج'); String get noNotifications=>_t('No notifications yet.','ابھی کوئی اطلاعات نہیں۔'); String get favorites=>_t('Saved businesses','محفوظ کاروبار'); String get noFavorites=>_t('No saved businesses yet. Browse the feed to save one.','ابھی کوئی محفوظ کاروبار نہیں۔ فیڈ سے کاروبار محفوظ کریں۔'); String get profileSettings=>_t('Profile & settings','پروفائل اور ترتیبات'); String get editProfile=>_t('Edit profile','پروفائل میں ترمیم'); String get notificationSettings=>_t('Notification settings','اطلاعات کی ترتیبات'); String get privacySecurity=>_t('Privacy & security','رازداری اور سیکیورٹی'); String get logout=>_t('Log out','لاگ آؤٹ');
}
