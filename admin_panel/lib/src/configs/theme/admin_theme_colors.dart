import 'package:flutter/material.dart';

class AdminThemeColors {
  AdminThemeColors._();

  static const purple = Color(0xFF6A1BFF);
  static const pink = Color(0xFFFF3D71);
  static const background = Color(0xFF111111);
  static const sidebar = Color(0xFF17161E);
  static const surface = Color(0xFF1B1B22);
  static const surfaceVariant = Color(0xFF282631);
  static const text = Color(0xFFFFFFFF);
  static const mutedText = Color(0xFFC9C4D0);
  static const outline = Color(0xFF4B4657);
  static const Gradient brandGradient = LinearGradient(
    colors: [purple, pink],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );
}
