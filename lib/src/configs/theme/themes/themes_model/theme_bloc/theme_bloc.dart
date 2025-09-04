import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../local_storage_sqflite/local_storage_sqflite.dart';
import '../../../../local_storage_sqflite/sqflite_model.dart';
import '../../../enums/theme_enum.dart';
import '../../../theme_config.dart';

part 'theme_event.dart';

part 'theme_state.dart';

/// A BLoC for managing the application's theme.
///
/// This BLoC handles theme-related events and emits theme-related states.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Creates a [ThemeBloc].
  ThemeBloc() : super(ThemeInitial()) {
    // Handle the CheckedSavedTheme event.
    on<CheckedSavedTheme>((event, emit) async {
      // Retrieve the currently saved theme flavor from local storage.
      final Data? currentThemeFlavorName =
          await LocalStorageSqfLite.getDataByKey(
            AppThemeConfig().themeStorageKey,
          );
      // Check if a theme flavor was found in local storage.
      if (currentThemeFlavorName != null) {
        // Get the ThemeFlavor enum value by name.
        final ThemeFlavor? themeFlavorByName = getThemeFlavorByName(
          currentThemeFlavorName.value,
        );
        // Check if the ThemeFlavor enum value was found.
        if (themeFlavorByName != null) {
          // Emit a ThemeFetched state with the retrieved theme flavor.
          emit(ThemeFetched(theme: themeFlavorByName));
        } else {
          // If the ThemeFlavor enum value was not found, insert the default theme flavor in local storage.
          LocalStorageSqfLite.insertData(
            Data(
              key: AppThemeConfig().themeStorageKey,
              value: ThemeFlavor.Default.name,
            ),
          );
          // Emit a ThemeFetched state with the default theme flavor.
          emit(ThemeFetched(theme: ThemeFlavor.Default));
        }
      } else {
        // If no theme flavor was found in local storage, insert the dark theme flavor in local storage.
        LocalStorageSqfLite.insertData(
          Data(
            key: AppThemeConfig().themeStorageKey,
            value: ThemeFlavor.Dark.name,
          ),
        );
        // Emit a ThemeFetched state with the dark theme flavor.
        emit(ThemeFetched(theme: ThemeFlavor.Dark));
      }
    });
    // Handle the SwitchAppTheme event.
    on<SwitchAppTheme>((event, emit) async {
      // Insert the updated theme flavor in local storage.
      LocalStorageSqfLite.insertData(
        Data(
          key: AppThemeConfig().themeStorageKey,
          value: event.updatedFlavor.name,
        ),
      );
      // Emit a ThemeFetched state with the updated theme flavor.
      emit(ThemeFetched(theme: event.updatedFlavor));
    });
  }
}
