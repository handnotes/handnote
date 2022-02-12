import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Future<String> getDatabaseFileName() async {
  final dbPath = await getDatabasesPath();
  const dbName = String.fromEnvironment("DB_NAME", defaultValue: "db.sqlite");
  final file = path.join(dbPath, dbName);
  if (kDebugMode) {
    print("database path: $dbPath, filename: $dbName");
  }
  return file;
}

Future<Database> connectDatabase() async {
  return openDatabase(
    await getDatabaseFileName(),
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE IF NOT EXISTS bill (
  id          TEXT    NOT NULL PRIMARY KEY,
  category    INT     NOT NULL,
  subCategory INT,
  outAssets   INT,
  outAmount   REAL,
  inAssets    INT,
  inAmount    REAL,
  date        INTEGER NOT NULL,
  description TEXT,
  created_at  INTEGER NOT NULL,
  updated_at  INTEGER NOT NULL
)''');
    },
  );
}
