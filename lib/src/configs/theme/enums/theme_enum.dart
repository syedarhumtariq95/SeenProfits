/// An enumeration representing the available theme flavors.
///
/// This enum defines the different visual themes that can be applied to the application.
enum ThemeFlavor {
  /// The default theme flavor.
  Default,

  /// The dark theme flavor.
  Dark,
}

/// Retrieves a [ThemeFlavor] by its name.
///
/// This function iterates through all the values of the [ThemeFlavor] enum and
/// returns the matching enum value if its name matches the provided name.
///
/// Args:
///   name: The name of the [ThemeFlavor] to retrieve.
///
/// Returns:
///   The matching [ThemeFlavor] if found, otherwise null.
ThemeFlavor? getThemeFlavorByName(String name) {
  for (final value in ThemeFlavor.values) {
    if (value.name == name) {
      return value;
    }
  }
  return null;
}
