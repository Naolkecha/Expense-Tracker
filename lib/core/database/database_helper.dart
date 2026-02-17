import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DatabaseHelper {
  static const String _databaseName = 'expense_tracker.db';
  static const int _databaseVersion = 1;

  static Future<Database> initDatabase() async {
    try {
      // Initialize database factory for web
      if (kIsWeb) {
        print('Initializing web database...');
        databaseFactory = databaseFactoryFfiWeb;
        print('Database factory set for web');
        
        final db = await databaseFactory.openDatabase(
          _databaseName,
          options: OpenDatabaseOptions(
            version: _databaseVersion,
            onCreate: _onCreate,
          ),
        );
        print('Web database opened successfully');
        return db;
      }
      
      // For mobile/desktop
      print('Initializing mobile/desktop database...');
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, _databaseName);
      print('Database path: $path');

      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } catch (e, stackTrace) {
      print('Database initialization failed: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        notes TEXT
      )
    ''');
  }
}

