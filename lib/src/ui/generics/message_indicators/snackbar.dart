import 'package:flutter/material.dart';
import '../../../configs/app/screen_config.dart';
import '../widgets/text/custom_text.dart';

/// A utility class for displaying custom snack bars.
///
/// This class provides a convenient way to trigger and display snack bars
/// with customized content, duration, and behavior.
class CustomSnackBar {
  /// Private constructor to prevent direct instantiation.
  ///
  /// This class is designed for static use only.
  CustomSnackBar._();

  /// Triggers the display of a custom snack bar.
  ///
  /// This method clears any existing snack bars and displays a new snack bar
  /// with the specified message and properties.
  ///
  /// Args:
  ///   context: The [BuildContext] in which to display the snack bar.
  ///   message: The message to display in the snack bar.
  ///   isError: A boolean indicating whether the snack bar represents an error.
  ///   needsTranslation: A boolean indicating whether the message needs translation.
  static void snackBarTrigger({
    required BuildContext context,
    required String message,
    required bool isError,
    bool needsTranslation = true,
  }) {
    try {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(_showSnackbar(message, needsTranslation, isError));
    } catch (e) {
      // Consider logging the error 'e' here for debugging purposes.
      // Example: debugPrint('Error showing snackbar: $e');
    }
  }

  /// Creates and returns a customized [SnackBar] widget.
  ///
  /// This method constructs a [SnackBar] with the given text, translation
  /// requirement, and error flag.
  ///
  /// Args:
  ///   text: The message text for the snack bar.
  ///   needsTranslation: Whether the text needs translation.
  ///   isError: Whether the snack bar indicates an error.
  ///
  /// Returns:
  ///   A [SnackBar] widget configured with the specified properties.
  static SnackBar _showSnackbar(
    String text,
    bool needsTranslation,
    bool isError,
  ) {
    return SnackBar(
      content: Directionality(
        textDirection: TextDirection.ltr,
        child: CustomText(
          text,
          needsTranslation: needsTranslation,
          textAlign: TextAlign.center,
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError
          ? ScreenConfig.theme.colorScheme.error
          : Colors.black,
    );
  }
}
