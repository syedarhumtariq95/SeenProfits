import 'package:flutter/material.dart';

class AdminThemeColors {
  AdminThemeColors._();

  static const deepPurple = Color(0xFF7E22CE);
  static const purple = Color(0xFF8B5CF6);
  static const pink = Color(0xFFC026D3);
  static const accent = Color(0xFFE11D48);
  static const background = Color(0xFF0F0F12);
  static const sidebar = Color(0xFF0F0F12);
  static const surface = Color(0xFF18181B);
  static const surfaceVariant = Color(0xFF1E1E24);
  static const text = Color(0xFFFFFFFF);
  static const mutedText = Color(0xFFC9C4D0);
  static const outline = Color(0xFF27272A);
  static const activeBackground = Color(0x268B5CF6);
  static const Gradient brandGradient = LinearGradient(
    colors: [deepPurple, purple, pink, accent],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );
}
