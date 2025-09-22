/// Represents a data item with a key-value pair.
///
/// This class is used to store data in the local storage,
/// where each item has a unique key and a corresponding value.
class Data {
  /// Creates a [Data] instance.
  ///
  /// Args:
  ///   key: The unique key for the data item.
  ///   value: The value associated with the key.
  Data({required this.key, required this.value});

  /// The unique key for the data item.
  final String key;

  /// The value associated with the key.
  final String value;

  /// Converts this [Data] instance to a map.
  ///
  /// This is useful for database operations where data is stored as key-value pairs.
  ///
  /// Returns:
  ///   A map representation of this [Data] instance.
  Map<String, dynamic> toMap() {
    return {'key': key, 'value': value};
  }
}
