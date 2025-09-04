import 'package:flutter/material.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/dependency_injection/navigation_service.dart';

/// A utility class for accessing the application's [BuildContext].
///
/// This class provides methods to retrieve the current [BuildContext] and to
/// execute functions within a safe context.
class AppContext {
  /// Private constructor to prevent instantiation.
  ///
  /// This class is designed to be used with static methods only.
  AppContext._();

  /// Retrieves the current application [BuildContext].
  ///
  /// This method uses the [NavigationService] from the dependency injection
  /// container to get the current [BuildContext].
  ///
  /// Returns:
  ///   The current [BuildContext] or null if not available.
  static BuildContext? getAppContext() {
    return DI.i<NavigationService>().getContext();
  }

  /// Executes a function within a context-safe environment.
  ///
  /// This method uses the [NavigationService] to run the given function in a
  /// way that handles potential context-related issues.
  ///
  /// Args:
  ///   function: The function to execute.
  static void contextSafeFunction(Function function) {
    DI.i<NavigationService>().runContextSafeFunction(function);
  }
}
