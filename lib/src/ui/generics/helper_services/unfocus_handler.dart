import 'package:flutter/material.dart';

/// A utility class for handling the unfocusing of the primary focus.
///
/// This class provides a static method to unfocus the current primary focus
/// in the application, typically used to dismiss the keyboard or remove focus
/// from a text field.
class UnfocusHandler {
  /// Private constructor to prevent instantiation.
  ///
  /// This class is designed to be used with static methods only.
  UnfocusHandler._();

  /// Unfocuses the current primary focus.
  ///
  /// This method finds the current primary focus and calls its `unfocus()`
  /// method, effectively removing the focus. This is useful for dismissing
  /// the keyboard or clearing focus from text fields when the user taps
  /// outside of them.
  static void unFocusPrimaryFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
