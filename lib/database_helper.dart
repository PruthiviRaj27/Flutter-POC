import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'my_database.db');

    _database = await openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE album(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT)',
      );
    }, version: 1);
  }

  static Database get database {
    return _database;
  }
}