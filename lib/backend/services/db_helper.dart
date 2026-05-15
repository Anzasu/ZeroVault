
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper{
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  static Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'zero_vault.db');
  return openDatabase(path,
  version: 1,
  onCreate: (db, version) async {
    await db.execute('''
    CREATE TABLE credentials (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      username_or_email TEXT NOT NULL,
      encrypted_password TEXT NOT NULL,
      encrypted_notes TEXT,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
    CREATE TABLE subscriptions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      newsletter_name TEXT NOT NULL,
      email TEXT NOT NULL,
      frequency TEXT,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
      )
    ''');
  },
  );
}
}

