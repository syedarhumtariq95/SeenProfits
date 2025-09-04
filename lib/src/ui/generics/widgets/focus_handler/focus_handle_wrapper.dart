import 'package:flutter/material.dart';

import '../../helper_services/unfocus_handler.dart';

/// A widget that unfocuses the primary focus when tapped.
///
/// This widget wraps its child in a [GestureDetector] that, when tapped,
/// unfocuses the current primary focus, typically dismissing the keyboard
/// or removing focus from a text field.
class FocusHandler extends StatelessWidget {
  /// Creates a [FocusHandler].
  ///
  /// Args:
  ///   key: An optional [Key] for the widget.
  ///   child: The widget to wrap with the focus handling behavior.
  const FocusHandler({
    super.key,
    required this.child,
  });

  /// The widget to be wrapped by the [FocusHandler].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// When the [GestureDetector] is tapped, call the
      /// [UnfocusHandler.unFocusPrimaryFocus] function to remove focus from
      /// any focused widgets.
      onTap: UnfocusHandler.unFocusPrimaryFocus,
      child: child,
    );
  }
}
