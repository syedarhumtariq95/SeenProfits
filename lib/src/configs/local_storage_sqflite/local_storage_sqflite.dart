import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'sqflite_model.dart';

/// A class for managing local data storage using SQLite.
///
/// This class provides methods for initializing the database,
/// inserting, retrieving, updating, and deleting data.
class LocalStorageSqfLite {
  /// The SQLite database instance.
  static late Database _database;

  /// Initializes the SQLite database.
  ///
  /// This method gets the database path, creates the database file if it doesn't exist,
  /// and defines the table schema.
  static Future<void> initDatabase() async {
    try {
      // Get the path to the databases directory.
      final databasesPath = await getDatabasesPath();
      // Construct the full path to the database file.
      final path = join(databasesPath, 'data.db');

      // Open the database or create it if it doesn't exist.
      _database = await openDatabase(
        path,
        version: 1,
        // Define the onCreate callback to create the table.
        onCreate: (db, version) async {
          // Execute the SQL statement to create the 'data' table.
          await db.execute(
            'CREATE TABLE data(key TEXT PRIMARY KEY, value TEXT)',
          );
        },
      );
    } catch (e) {
      // Print any error that occurs during database initialization.
      debugPrint(e.toString());
    }
  }

  /// Inserts or updates data in the database.
  ///
  /// If a data item with the same key already exists, it will be updated.
  /// Otherwise, a new data item will be inserted.
  ///
  /// Args:
  ///   data: The data item to insert or update.
  static Future<void> insertData(Data data) async {
    try {
      // Check if a data item with the same key already exists.
      final Data? currentDataItem = await getDataByKey(data.key);
      if (currentDataItem != null) {
        // Update the existing data item.
        await _database.update(
          'data',
          data.toMap(),
          where: 'key = ?',
          whereArgs: [data.key],
        );
      } else {
        // Insert a new data item.
        await _database.insert('data', data.toMap());
      }
    } catch (e) {
      // Print any error that occurs during data insertion or update.
      debugPrint(e.toString());
    }
  }

  /// Retrieves all data rows from the database.
  ///
  /// Returns:
  ///   A list of all data items in the database.
  static Future<List<Data>> getAllDataRows() async {
    // Query all rows from the 'data' table.
    final List<Map<String, dynamic>> maps = await _database.query('data');
    // Convert the list of maps to a list of Data objects.
    return List.generate(maps.length, (i) {
      return Data(
        key: maps[i]['key'].toString(),
        value: maps[i]['value'].toString(),
      );
    });
  }

  /// Retrieves a data item by its key.
  ///
  /// Args:
  ///   key: The key of the data item to retrieve.
  ///
  /// Returns:
  ///   The data item if found, otherwise null.
  static Future<Data?> getDataByKey(String key) async {
    try {
      // Query the 'data' table for a row with the specified key.
      final List<Map<String, dynamic>> maps = await _database.query(
        'data',
        where: 'key = ?',
        whereArgs: [key],
      );

      // Check if any data items were found.
      if (maps.isNotEmpty) {
        // Return the first data item.
        return Data(
          key: maps[0]['key'].toString(),
          value: maps[0]['value'].toString(),
        );
      } else {
        // Return null if no data item was found.
        return null; // No task found with the specified ID
      }
    } catch (e) {
      // Print any error that occurs during data retrieval.
      debugPrint(e.toString());
    }
    return null;
  }

  /// Updates a data item in the database.
  ///
  /// Args:
  ///   data: The data item to update.
  static Future<void> updateData(Data data) async {
    try {
      // Update the data item in the database.
      await _database.update(
        'data',
        data.toMap(),
        where: 'key = ?',
        whereArgs: [data.key],
      );
    } catch (e) {
      // Print any error that occurs during data update.
      debugPrint(e.toString());
    }
  }

  /// Deletes a data item from the database by its key.
  ///
  /// Args:
  ///   key: The key of the data item to delete.
  static Future<void> deleteData(String key) async {
    try {
      // Delete the data item from the database.
      await _database.delete('data', where: 'key = ?', whereArgs: [key]);
    } catch (e) {
      // Print any error that occurs during data deletion.
      debugPrint(e.toString());
    }
  }
}
