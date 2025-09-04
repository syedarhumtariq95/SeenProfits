part of 'theme_bloc.dart';

/// Base class for theme-related events.
///
/// This class serves as the foundation for all events that can be dispatched
/// to the [ThemeBloc]. All concrete theme events should extend this class.
abstract class ThemeEvent {}

/// Event indicating that the application should check the saved theme.
///
/// This event is typically dispatched when the application starts to
/// determine the initial theme to apply.
class CheckedSavedTheme extends ThemeEvent {}

/// Event indicating that the application theme should be switched.
///
/// This event is dispatched when the user requests to change the
/// application's theme.
class SwitchAppTheme extends ThemeEvent {
  /// Creates a [SwitchAppTheme] event.
  SwitchAppTheme({required this.updatedFlavor});

  /// The updated theme flavor.
  final ThemeFlavor updatedFlavor;
}
