import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

Future<String> loadSqlFile(int version) async {
  return await rootBundle.loadString("assets/migration/sqlite/v$version.sql");
}

Future<void> cleanDatabase() async {
  await deleteDatabase(await getDatabaseFileName());
}

Future<Database> connectDatabase() async {
  return openDatabase(
    await getDatabaseFileName(),
    version: 1,
    onCreate: (Database db, int version) async {
      var scripts = (await loadSqlFile(1)).split(";");
      for (var script in scripts) {
        final sql = script
            .trim()
            .replaceAll(RegExp(r"--.*$", multiLine: true), "") // remove comments
            .replaceAll(RegExp(r"\s+"), " "); // squash whitespace
        if (sql.isEmpty) continue;
        await db.execute(sql);
      }
    },
  );
}
