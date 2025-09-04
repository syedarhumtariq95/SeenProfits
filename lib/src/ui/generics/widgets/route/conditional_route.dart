import 'package:flutter/material.dart';

/// A widget that conditionally applies a transition builder to its child based on the current route.
///
/// This widget allows you to specify a list of routes where a custom
/// [TransitionBuilder] should be applied, or a list of routes where the
/// transition should *not* be applied. It ensures that only one of `routes`
/// or `routesExcluded` is provided to avoid conflicts.
class ConditionalRouteWidget extends StatelessWidget {
  /// Creates a [ConditionalRouteWidget].
  ///
  /// Args:
  ///   key: An optional [Key] for the widget.
  ///   routes: A list of route names where the `builder` should be applied.
  ///   routesExcluded: A list of route names where the `builder` should *not* be applied.
  ///   builder: The [TransitionBuilder] to apply to the child.
  ///   child: The widget to conditionally apply the `builder` to.
  ///
  /// Throws:
  ///   AssertionError: If both `routes` and `routesExcluded` are provided.
  const ConditionalRouteWidget({
    super.key,
    this.routes,
    this.routesExcluded,
    required this.builder,
    required this.child,
  }) : assert(routes == null || routesExcluded == null,
            'Cannot include `routes` and `routesExcluded`. Please provide an list of routes to include or exclude, not both.');

  /// A list of route names where the `builder` should be applied.
  final List<String>? routes;

  /// A list of route names where the `builder` should *not* be applied.
  final List<String>? routesExcluded;

  /// The [TransitionBuilder] to apply to the child.
  final TransitionBuilder builder;

  /// The widget to conditionally apply the `builder` to.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    /// Get the current route name.
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    /// If `routes` is specified and the current route is in the list, apply the builder.
    if (routes != null && routes!.contains(currentRoute)) {
      return builder(context, child);

      /// If `routesExcluded` is specified and the current route is *not* in the list, apply the builder.
    } else if (routesExcluded != null &&
        !routesExcluded!.contains(currentRoute)) {
      return builder(context, child);
    }

    /// Otherwise, return the child without applying the builder.
    return child;
  }
}
