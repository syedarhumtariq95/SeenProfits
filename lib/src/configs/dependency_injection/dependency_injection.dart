import 'package:get_it/get_it.dart';
import '../theme/themes/themes_model/theme_bloc/theme_bloc.dart';
import 'navigation_service.dart';

/// A service locator class for managing dependencies using `GetIt`.
///
/// This class provides a way to register and retrieve dependencies
/// throughout the application.
class DI {
  /// The `GetIt` instance used for dependency injection.
  static GetIt i = GetIt.I;

  /// Initializes the dependency injection container.
  ///
  /// This method registers various services and BLoCs as lazy singletons,
  /// meaning they will be created only when they are first accessed.
  static void init() {
    // Register the NavigationService as a lazy singleton.
    i.registerLazySingleton(() => NavigationService());
    // Register the ThemeBloc as a lazy singleton.
    i.registerLazySingleton(() => ThemeBloc());
  }
}
