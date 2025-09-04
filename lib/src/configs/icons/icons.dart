import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    this.shadows,
    this.applyTextScaling,
    this.fill,
    this.grade,
    this.opticalSize,
    this.weight,
    this.onTap,
  });

  final String iconPath;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final List<Shadow>? shadows;
  final bool? applyTextScaling;
  final double? fill;
  final double? grade;
  final double? opticalSize;
  final double? weight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final iconWidget = SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        color ?? (brightness == Brightness.dark ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
      width: size,
      height: size,
      semanticsLabel: semanticLabel,
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: iconWidget);
    }
    return iconWidget;
  }
}

class CustomIconsPath {
  CustomIconsPath._();

  /// Icon paths for onboarding screens
  static const String apple = 'assets/icons/apple.svg';
  static const String google = 'assets/icons/google.svg';
  static const String nextIconWithText = 'assets/icons/nextIconWithText.svg';

  /// Icon paths for general use
  static const String notification = 'assets/icons/notification.svg';
  static const String arrowDownTilted = 'assets/icons/downArrowTilted.svg';
}
