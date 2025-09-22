/// Enum representing the different environments or flavors the application can run in.
///
/// This enum is used to identify the current operational environment of the application,
/// such as development, staging, or production.
enum EnvironmentFlavours {
  /// Indicates that no specific environment has been set.
  none,

  /// Indicates that the application is running in the development environment.
  /// This environment is typically used by developers during the development phase.
  development, //for developers
  /// Indicates that the application is running in the qa environment.
  /// This environment is typically used by qa during the development phase.
  qa, //for qa testing
  /// Indicates that the application is running in the staging environment.
  /// This environment is typically used for client testing and beta testing.
  staging, //for client testing(beta)
  /// Indicates that the application is running in the production environment.
  /// This is the environment used by the end-users or consumers.
  production, //for consumers
}
