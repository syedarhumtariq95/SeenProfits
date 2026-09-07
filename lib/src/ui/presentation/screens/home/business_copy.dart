import 'package:flutter/material.dart';

/// UI-only copy for the Business portal. Keeping it in one place makes the
/// static prototype usable in both supported app languages without backend data.
class BusinessCopy {
  const BusinessCopy._(this.isUrdu);

  factory BusinessCopy.of(BuildContext context) =>
      BusinessCopy._(Localizations.localeOf(context).languageCode == 'ur');

  final bool isUrdu;

  String text(String english, String urdu) => isUrdu ? urdu : english;

  String get dashboard => text('Business dashboard', 'کاروباری ڈیش بورڈ');
  String get addBusiness => text('Add business', 'کاروبار شامل کریں');
  String get verification => text('Verification', 'تصدیق');
  String get seekInvestment => text('Seek investment', 'سرمایہ طلب کریں');
  String get requests =>
      text('Investment requests', 'سرمایہ کاری کی درخواستیں');
  String get chats => text('Messages', 'پیغامات');
  String get profile => text('Business profile', 'کاروباری پروفائل');
  String get settings => text('Settings', 'ترتیبات');
  String get notifications => text('Notifications', 'اطلاعات');
  String get approved => text('Approved', 'منظور شدہ');
  String get pending => text('Under review', 'جائزے کے تحت');
  String get rejected => text('Rejected', 'مسترد');
  String get changesRequired => text('Changes required', 'تبدیلیاں درکار');
  String get suspended => text('Suspended', 'معطل');
  String get noBusiness =>
      text('No business added yet', 'ابھی کوئی کاروبار شامل نہیں کیا گیا');
  String get addBusinessHint => text(
      'Add your business, complete verification, and then share an opportunity with investors.',
      'اپنا کاروبار شامل کریں، تصدیق مکمل کریں، پھر سرمایہ کاروں کے ساتھ موقع شیئر کریں۔');
  String get reviewHint => text(
      'Your submitted information is read-only while our team reviews it. Estimated review time: 2–3 business days.',
      'آپ کی جمع کردہ معلومات جائزے کے دوران صرف پڑھنے کے لیے ہیں۔ متوقع وقت: 2 سے 3 کاروباری دن۔');
  String get status => text('Status', 'حیثیت');
  String get edit => text('Edit', 'ترمیم');
  String get resubmit =>
      text('Correct and resubmit', 'درست کر کے دوبارہ جمع کریں');
  String get contactSupport => text('Contact support', 'سپورٹ سے رابطہ کریں');
  String get dashboardSummary => text('Business summary', 'کاروباری خلاصہ');
  String get performance =>
      text('Revenue & profit performance', 'آمدنی اور منافع کی کارکردگی');
  String get investmentStatus =>
      text('Investment status', 'سرمایہ کاری کی حیثیت');
  String get open => text('Open', 'کھلا');
  String get committed => text('Committed', 'وعدہ شدہ');
  String get investorInterest =>
      text('New investor interest', 'نئی سرمایہ کار دلچسپی');
  String get activeRequests => text('Active requests', 'فعال درخواستیں');
  String get viewAll => text('View all', 'سب دیکھیں');
  String get next => text('Next', 'اگلا');
  String get back => text('Back', 'واپس');
  String get reviewSubmission =>
      text('Review submission', 'جمع کرانے کا جائزہ');
  String get submit => text('Submit for verification', 'تصدیق کے لیے جمع کریں');
  String get submitted =>
      text('Submitted for review', 'جائزے کے لیے جمع کر دیا گیا');
  String get required => text('This field is required.', 'یہ خانہ ضروری ہے۔');
  String get businessInformation =>
      text('Business information', 'کاروباری معلومات');
  String get financialInformation =>
      text('Financial information', 'مالی معلومات');
  String get documents => text('Verification documents', 'تصدیقی دستاویزات');
  String get businessName => text('Business title', 'کاروبار کا عنوان');
  String get category => text('Business category', 'کاروباری زمرہ');
  String get age =>
      text('Business start date / age', 'کاروبار شروع ہونے کی تاریخ / عمر');
  String get location => text('Business location', 'کاروباری مقام');
  String get lastMonthRevenue =>
      text('Last month revenue / sales bill', 'گزشتہ ماہ کی آمدنی / سیلز بل');
  String get monthlyRevenue =>
      text('Average monthly revenue', 'اوسط ماہانہ آمدنی');
  String get monthlyExpenses =>
      text('Average monthly expenses', 'اوسط ماہانہ اخراجات');
  String get bankAccount => text('Bank account number', 'بینک اکاؤنٹ نمبر');
  String get privateHint => text(
      'Private — only used for verification and never shown to investors.',
      'نجی — صرف تصدیق کے لیے استعمال ہوتا ہے اور سرمایہ کاروں کو نہیں دکھایا جاتا۔');
  String get amount =>
      text('Required investment amount', 'مطلوبہ سرمایہ کاری کی رقم');
  String get purpose => text('Investment purpose', 'سرمایہ کاری کا مقصد');
  String get terms => text('Proposed return / profit-sharing terms',
      'مجوزہ منافع / منافع کی شراکت کی شرائط');
  String get duration => text('Investment duration', 'سرمایہ کاری کی مدت');
  String get disclaimer => text(
      'Seen Profits does not guarantee returns, does not verify financial projections beyond submitted documents, and is not a party to any investment agreement. This is a discovery and connection platform only.',
      'سین پرافٹس منافع کی ضمانت نہیں دیتا، جمع شدہ دستاویزات سے بڑھ کر مالی پیش گوئیوں کی تصدیق نہیں کرتا، اور کسی سرمایہ کاری معاہدے کا فریق نہیں ہے۔ یہ صرف دریافت اور رابطے کا پلیٹ فارم ہے۔');
  String get createOpportunity => text('Publish opportunity', 'موقع شائع کریں');
  String get opportunityPublished =>
      text('Mock opportunity published', 'نمونہ موقع شائع ہو گیا');
  String get documentUploaded => text('Uploaded', 'اپ لوڈ شدہ');
  String get documentNeeded => text('Required', 'ضروری');
  String get requestEmpty => text(
      'No investment requests yet', 'ابھی سرمایہ کاری کی کوئی درخواست نہیں ہے');
  String get chatEmpty =>
      text('No conversations yet', 'ابھی کوئی گفتگو نہیں ہے');
  String get notificationEmpty =>
      text('No notifications yet', 'ابھی کوئی اطلاع نہیں ہے');
  String get typeMessage => text('Type a message', 'پیغام لکھیں');
  String get report => text('Report conversation', 'گفتگو کی رپورٹ کریں');
  String get block => text('Block investor', 'سرمایہ کار کو بلاک کریں');
  String get markRead =>
      text('Mark all as read', 'سب کو پڑھا ہوا نشان زد کریں');
  String get language => text('Language', 'زبان');
  String get account => text('Account settings', 'اکاؤنٹ ترتیبات');
  String get logout => text('Log out', 'لاگ آؤٹ');
  String get mockOnly => text('Static UI only — no information is submitted.',
      'صرف جامد UI — کوئی معلومات جمع نہیں کی جاتی۔');
}
