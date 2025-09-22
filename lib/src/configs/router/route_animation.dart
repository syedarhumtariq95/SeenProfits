import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A utility class for creating custom route transitions.
///
/// This class provides a static method for creating a fade-through
/// transition between routes.
class Routes {
  /// Creates a fade-through transition between routes.
  ///
  /// This method builds a [PageRouteBuilder] with a fade-through animation
  /// effect using [FadeScaleTransition].
  ///
  /// Args:
  ///   settings: The route settings.
  ///   page: A [WidgetBuilder] function that builds the page widget.
  ///   duration: The duration of the transition animation in milliseconds.
  ///             Defaults to 300 milliseconds.
  ///
  /// Returns:
  ///   A [Route] with the fade-through transition.
  static Route<T> fadeThrough<T>(
    RouteSettings settings,
    WidgetBuilder page, {
    int duration = 300,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      // Set the transition duration.
      transitionDuration: Duration(milliseconds: duration),
      // Build the page widget.
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      // Define the transition animation.
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Use FadeScaleTransition for the fade-through effect.
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
