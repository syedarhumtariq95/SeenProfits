import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/configs/app/app_config.dart';
import 'src/configs/app/environment_flavours.dart';
import 'src/configs/dependency_injection/dependency_injection.dart';
import 'src/configs/local_storage_sqflite/local_storage_sqflite.dart';

/// The main entry point of the application.
Future<void> main() async {
  // Ensure that Flutter bindings are initialized.
  // This is necessary to interact with the Flutter engine before calling runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the application's configuration.
  // This sets the environment (e.g., production) and the displayed app version.
  AppConfig.init(
    environment: EnvironmentFlavours.development,
    appVersionToShow: '0.0.1',
  );

  // Set the preferred device orientation to portrait mode only.
  // This prevents the app from rotating to landscape.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize the local database using SQLite.
  // This sets up the database for storing local data.
  await LocalStorageSqfLite.initDatabase();

  // Initialize the dependency injection system.
  // This sets up the instances of classes that are managed by the DI container.
  DI.init();

  // Run the Flutter app, wrapping it in a BlocProvider.
  // This sets up the TranslationBloc for state management related to translations.
  runApp(const App());
}
