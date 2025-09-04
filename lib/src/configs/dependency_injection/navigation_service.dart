import 'package:flutter/material.dart';

/// A service for managing navigation and related UI interactions.
///
/// This class provides methods to navigate between screens,
/// run context-safe functions, show custom dialogs, and more.
class NavigationService {
  /// The global key for the navigator.
  ///
  /// This key is used to perform navigation operations.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Returns the global key for the navigator.
  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;

  /// Returns the current BuildContext from the navigator key.
  ///
  /// This getter can return null if the navigator is not currently in the widget tree.
  BuildContext? get _context => _navigatorKey.currentContext;

  /// The global key for the scaffold.
  ///
  /// This key is used to interact with the scaffold (e.g., showing snack bars).
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns the global key for the scaffold.
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  /// Navigates to a new route using the provided navigation function.
  ///
  /// Args:
  ///   navigationFunc: A function that takes a BuildContext and performs navigation.
  navigateTo(Function(BuildContext context) navigationFunc) {
    // Execute the navigation function with the current context.
    navigationFunc(_navigatorKey.currentContext!);
  }

  /// Runs a function if the BuildContext is available.
  ///
  /// This method checks if a valid BuildContext is available and then executes the provided function.
  /// If the context is null, it prints a debug message.
  ///
  /// Args:
  ///   function: The function to run.
  void runContextSafeFunction(Function function) {
    // Check if the context is not null.
    if (_context != null) {
      // Execute the function.
      function();
    } else {
      // Print a debug message if the context is null.
      debugPrint('Null Context Found');
    }
  }

  /// Shows a custom dialog.
  ///
  /// This method displays a custom dialog widget.
  ///
  /// Args:
  ///   dialog: The custom dialog widget to display.
  ///
  /// Returns:
  ///   A Future that completes when the dialog is dismissed.
  Future<dynamic> showCustomDialog(Widget dialog) async {
    return await showDialog(
      context: _navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  /// Returns the current BuildContext.
  ///
  /// This getter can return null if the navigator is not currently in the widget tree.
  BuildContext? getContext() => _context;
}
