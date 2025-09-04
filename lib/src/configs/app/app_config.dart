import 'dart:io';

import 'application_platforms.dart';
import 'environment_flavours.dart';

/// Configuration class for application settings.
///
/// This class manages various app settings like the environment, server URLs,
/// app versioning, and the platform the app is running on.
class AppConfig {
  // Private static properties:
  // These properties store the app's configuration data and are accessible
  // through static methods.

  /// The current environment (e.g., development, staging, production).
  static late final EnvironmentFlavours _environment;

  /// The base URL of the server.
  static late final String _serverUrl;

  /// The URL for server API requests.
  static late final String _serverApiUrl;

  /// The URL for accessing server images.
  static late final String _serverImageUrl;

  /// The URL for server socket connections.
  static late final String _serverSocketUrl;

  // Base URLs for different environments:
  // These are constant strings representing the base URLs for different environments.
  /// Base URL for the production environment.
  static const String _baseUrlProduction = '';

  /// Base URL for the staging environment.
  static const String _baseUrlStaging = '';

  /// Base URL for the development environment.
  static const String _baseUrlDevelopment = '';

  /// Base URL for when no environment is found.
  static const String _baseUrlNotFound = 'none';

  // URL extensions:
  // These are constant strings that are appended to the base URLs to form
  // specific URLs for API requests, images, and sockets.
  /// Extension for API URLs.
  static const String _apiUrlExtension = '';

  /// Extension for image URLs.
  static const String _imageUrlExtension = '';

  /// Extension for socket URLs.
  static const String _socketUrlExtension = 'socket';

  /// The app version string to show (e.g., "V: BetaDev-1.0.0").
  static late final String _appVersionToShow;

  // App name prefixes for different environments:
  // These are used to generate the app version string.
  /// Prefix for beta development app versions.
  static const String _appNameBeta = 'V: Dev-';

  /// Prefix for staging app versions.
  static const String _appNameStaging = 'V: Beta-';

  /// Prefix for production app versions.
  static const String _appNameProduction = 'V: Prod-';

  /// The operating system the app is running on.
  static late final ApplicationPlatforms _appOperatingSystem;

  /// Initializes the application configuration.
  ///
  /// This method must be called before using any other methods of this class.
  /// It sets up the environment, server URLs, app version, and operating system.
  ///
  /// Args:
  ///   environment: The current environment (e.g., development, staging, production).
  ///   appVersionToShow: The app version string to display.
  static void init({
    required EnvironmentFlavours environment,
    required String appVersionToShow,
  }) {
    _environment = environment;
    // Set the app version and server URL based on the environment.
    if (_environment == EnvironmentFlavours.development) {
      _appVersionToShow = _appNameBeta + appVersionToShow;
      _serverUrl = _baseUrlDevelopment;
    } else if (_environment == EnvironmentFlavours.staging) {
      _appVersionToShow = _appNameStaging + appVersionToShow;
      _serverUrl = _baseUrlStaging;
    } else if (_environment == EnvironmentFlavours.production) {
      _appVersionToShow = _appNameProduction + appVersionToShow;
      _serverUrl = _baseUrlProduction;
    } else {
      _appVersionToShow = appVersionToShow;
      _serverUrl = _baseUrlNotFound;
    }

    // Build the complete URLs using the base URL and extensions.
    _serverApiUrl = _serverUrl + _apiUrlExtension;
    _serverImageUrl = _imageUrlExtension;
    // _serverImageUrl = _serverUrl + _imageUrlExtension;
    _serverSocketUrl = _serverUrl + _socketUrlExtension;

    // Determine the operating system the app is running on.
    if (Platform.isAndroid) {
      _appOperatingSystem = ApplicationPlatforms.ANDROID;
    } else if (Platform.isIOS) {
      _appOperatingSystem = ApplicationPlatforms.IOS;
    } else {
      _appOperatingSystem = ApplicationPlatforms.OTHER;
    }
  }

  // Getter methods:
  // These methods provide read-only access to the configuration data.

  /// Returns the current environment.
  static EnvironmentFlavours getEnvironment() {
    return _environment;
  }

  /// Returns the platform the app is running on.
  static ApplicationPlatforms getAppPlatform() {
    return _appOperatingSystem;
  }

  /// Returns the app version string to show.
  static String getAppVersionToShow() {
    return _appVersionToShow;
  }

  /// Returns the image URL.
  static String getImageUrl() {
    return _serverImageUrl;
  }

  /// Returns the API URL.
  static String getApiUrl() {
    return _serverApiUrl;
  }

  /// Returns the socket URL.
  static String getSocketUrl() {
    return _serverSocketUrl;
  }
}
