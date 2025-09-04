// Flutter imports:
import 'package:flutter/material.dart';

import '../theme/enums/theme_enum.dart';
import '../theme/theme_config.dart';

/// A utility class to manage screen configuration and dimensions.
///
/// This class provides methods to calculate and access screen dimensions,
/// safe area insets, and other device-specific information.
class ScreenConfig {
  /// Stores the MediaQueryData for the current context.
  late MediaQueryData _mediaQueryData;

  /// The width of the screen in logical pixels.
  late double _screenWidth;

  /// The height of the screen in logical pixels.
  late double _screenHeight;

  /// The total horizontal safe area inset (left + right).
  late double _safeAreaHorizontal;

  /// The total vertical safe area inset (top + bottom).
  late double _safeAreaVertical;

  /// The width of a horizontal block, based on dividing the safe area by 100.
  late double _safeBlockHorizontal;

  /// The height of a vertical block, based on dividing the safe area by 100.
  late double _safeBlockVertical;

  /// The application's theme data.
  static late ThemeData theme;

  /// The screen's width, adjusted for safe area.
  static late double screenSizeWidth;

  /// The screen's height, adjusted for safe area.
  static late double screenSizeHeight;

  /// The device's pixel ratio.
  static late double devicePixelRatio;

  /// The device's text scale factor.
  static late TextScaler textScaler;

  /// Initializes the screen configuration.
  ///
  /// This method must be called in the build method of the root widget to
  /// get the correct screen dimensions and other device-specific information.
  ///
  /// Args:
  ///   context: The BuildContext of the root widget.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
    theme = AppThemeConfig().getThemeData(ThemeFlavor.Default);
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    screenSizeWidth = _safeBlockHorizontal * 100;
    screenSizeHeight = _safeBlockVertical * 100;
    textScaler = _mediaQueryData.textScaler;
  }
}
