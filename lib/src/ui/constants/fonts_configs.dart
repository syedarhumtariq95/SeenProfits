import 'package:flutter/material.dart';

class FontsConfigs {
  FontsConfigs._();

  //Font family names
  static const String abhayaFonts = 'AbhayaLibre';
  static const String soraFonts = 'SoraBold';
  static const String sfProFonts = 'SfProDisplay';
}

class FontTheme {
  final FontWeight? fontWeight;

  FontTheme({this.fontWeight});

  //TextTheme configurations
  TextTheme get textTheme => TextTheme(
    displayLarge: TextStyle(
      fontFamily: FontsConfigs.abhayaFonts,
      fontSize: 32.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 30.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 28.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),

    headlineLarge: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 26.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 24.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    headlineSmall: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 22.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),

    titleLarge: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 20.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    titleMedium: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 18.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    titleSmall: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),

    bodyLarge: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 14.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 12.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 10.0,
      fontWeight: FontWeight.normal,
    ),

    labelLarge: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 8.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 6.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontFamily: FontsConfigs.sfProFonts,
      fontSize: 4.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
  );
}

// class FontSizeConfig {
//   FontSizeConfig._();
//
//   static fontSize16() {
//     return FontTheme().textTheme.bodyMedium?.copyWith(fontSize: 16.0);
//   }
// }
