// Flutter imports:
import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  // Seen Profits brand palette.
  static const Color seenProfitsPurple = Color(0xFF6A1BFF);
  static const Color seenProfitsPink = Color(0xFFFF3D71);
  static const Color seenProfitsDark = Color(0xFF111111);
  static const Color seenProfitsSurface = Color(0xFF1B1B22);
  static const Color seenProfitsSurfaceVariant = Color(0xFF282631);
  static const Color seenProfitsText = Color(0xFFFFFFFF);
  static const Color seenProfitsMutedText = Color(0xFFC9C4D0);
  static const Color seenProfitsOutline = Color(0xFF4B4657);
  static const Gradient seenProfitsGradient = LinearGradient(
    colors: [seenProfitsPurple, seenProfitsPink],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  // Light Theme Colors
  static const Color kThemeColor = Color(0xFF00796B);
  static const Color kThemePrimaryColor = Color(0xFF009688);
  static const Color kThemePrimaryLightColor = Color(0x66009688);
  static const Gradient kThemeGradientColor = LinearGradient(
    colors: [ThemeColors.kThemePrimaryColor, Color(0xFF13A88D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color kAppBarColor = kThemePrimaryColor;
  static const Color kBottomBarColor = kThemeColor;
  static const Color kScaffoldBackgroundColor = Colors.white;
  static const Color kButtonColor = kThemeColor;
  static const Color kButtonSecondaryColor = Color(0xFFF1F2F6);
  static const Color kNavBarBackgroundBlueColor = Color(0xFF325F8D);
  static const Color kBoxShadowColor = Color(0xFF4F4F4F);
  static const Color kBoxColor = Color(0xfff4f4f4);
  static const Color kTableBoxShadowColor = Color(0xA3BFBFBF);
  static const Color kIconColor = Color(0xFF7C7C7C);
  static const Color wheelChartHeading = Color(0xFF696969);
  static Color kCardShadowColor = Colors.grey.shade200;
  static const Color kButtonDarkBlueColor = Color(0xFF325F8D);
  static const Color kButtonTextColor = Colors.white;
  static const Color kButtonTextSecondaryColor = Color(0xFFC0C0C0);
  static const Color kBottomNavigationBarBackgroundColor = Color(0xFF78BBFF);
  static const Color kBottomNavigationBarTextUnselectedColor = Colors.black;
  static const Color kBottomNavigationBarTextSelectedColor = Colors.white;
  static const Color kErrorRedColor = Color(0xFFD44B3B);
  static const Color kLightRedColor = Color(0xFFFF5353);
  static const Color kLightGreenColor = Color(0xFF3CA165);
  static const Color kDarkGreenColor = Color(0xFF026832);
  static const Color kBrandGoldColor = Color(0xFFF4B740);
  static const Color kLightOrangeColor = Color(0xFFFFD883);
  static const Color kDarkOrangeColor = Color(0xFF683F02);

  //TextField
  static const Color kPhoneVerificationTextFieldInputColor = Color(0xFFC7C7C7);
  static const Color kTextFieldColor = Color(0x2AFFAB67);
  static const Color kLighterTextFieldColor = Color(0x0fffab67);

  // Font Colors
  static const Color kFontPrimaryColor = Color(0xFF212B36);
  static const Color kFontSecondaryBlueColor = Color(0xFF325F8D);
  static const Color kFontPrimaryGreyColor = Color(0xFF979797);
  static const Color kOutlineColor = Color(0xFFE1E1E1);
  static const Color kChartFontColor = Color(0xFF2B2B2B);
  static const Color kChartSecondaryFontColor = Color(0xFF454545);
  static const Color kTableSecondaryFontColor = Color(0xFF7A7A7A);
  static const Color kDrawerSecondaryFontColor = Color(0xFF595959);
  static const Color kFontSecondaryGreyColor = Color(0xFF101010);

  static const Color kFontHintColor = Color(0xFFC1C1C1);
  static const Color kFontSearchHintColor = Color(0xFFC1C1C1);
  static const Color kFontBlueHintColor = Color(0xffdbe9fd);

  static const Color kFontTabBarUnselectedColor = Color(0xFFC1BDBD);
  static const Color kOrderCardInActiveColor = Color(0xFFEAEAEA);

  // OTP Field Colors
  static const Color kOtpFieldInActiveColor = Color(0xFFD9D9D9);

  // Discount
  static const Color inActiveCell = Color.fromARGB(255, 219, 219, 219);
  static const Color inActiveBox = Color.fromARGB(255, 70, 70, 70);

  // Extra Colors App Dependent
  static const Color kOrderStatusInProgressColor = Color(0xFF04B700);
  static const Color kOrderStatusDeliveredOnColor = Color(0xFFFF9900);

  static const Color kInvoiceStatusPaidColor = Color(0xFF00B127);
  static const Color kInvoiceStatusUnpaidColor = Color(0xFFD80303);

  // Product Tile Display
  static const Color kIconButtonGreyColor = Color(0xFFCBCBCB);
  static const Color kIconButtonLightGreyColor = Color(0xFFE6E6E6);

  // Order Table
  static const Color kAvatarBackgroundColor = Color(0xFFD5D5D5);

  static const Color kMyAccountDividerColor = Color.fromARGB(
    255,
    238,
    238,
    240,
  );

  // Product Suggestion Colors
  static const Color kBackgroundLightGreyColor = Color(0xFFEDEDED);

  // TabBar
  static const Color unselectedLabelColor = Color(0x61353535);
  static const Color selectedLabelColor = Color(0xFF2772FF);

  // Trend Data
  static const Color kTrendData1 = Color(0xFF1877f2);
  static const Color kTrendData2 = Color(0xFFffab00);
  static const Color kTrendData3 = Color(0xFF00b8d9);
  static const Color trendsShadowColor = Color(0x61FFFFFF);
  static const Color kChartFontPrimaryColor = Color(0xFFEFEFEF);

  // Dark Theme Colors
  static const Color kDarkThemeColor = Color(0xFF121212);
  static const Color kDarkThemePrimaryColor = Color(0xFF1E88E5);
  static const Color kDarkScaffoldBackgroundColor = Color(0xFF181818);
  static const Color kDarkBoxColor = Color(0xff2e2e2e);
  static const Color kDarkAppBarColor = kDarkThemeColor;
  static const Color kDarkBottomBarColor = kDarkThemeColor;
  static const Color kDarkButtonColor = kDarkThemePrimaryColor;
  static const Color kDarkButtonTextColor = Colors.white;
  static const Color kDarkFontPrimaryColor = Colors.white;
  static const Color kDarkFontSecondaryColor = Color(0xFFB0BEC5);
  static const Color kDarkIconColor = Colors.white70;
  static const Color kDarkCardShadowColor = Colors.black; //Color(0xFF2E2E2E);
  static const Color kDarkBoxShadowColor = Color(0xFF000000);
}
