part of 'theme_bloc.dart';

/// Base class for theme-related states.
///
/// This class serves as the foundation for all states emitted by the [ThemeBloc].
/// All concrete theme states should extend this class.
abstract class ThemeState {}

/// State indicating that the theme has not yet been initialized.
///
/// This state is the initial state of the [ThemeBloc].
class ThemeInitial extends ThemeState {}

/// State indicating that a theme has been fetched.
///
/// This state is emitted when a theme has been successfully retrieved
/// from local storage or when a theme has been switched.
class ThemeFetched extends ThemeState {
  /// Creates a [ThemeFetched] state.
  ThemeFetched({required this.theme});

  /// The fetched theme flavor.
  final ThemeFlavor theme;
}
