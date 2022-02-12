import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

final logger = Logger("Database");

Future<String> getDatabaseFileName() async {
  final dbPath = await getDatabasesPath();
  const dbName = String.fromEnvironment("DB_NAME", defaultValue: "db.sqlite");
  return path.join(dbPath, dbName);
}

Future<String> loadSqlFile(int version) async {
  return await rootBundle.loadString("assets/migration/sqlite/v$version.sql");
}

Future<void> cleanDatabase() async {
  await deleteDatabase(await getDatabaseFileName());
}

Future<Database> connectDatabase() async {
  var dbPath = await getDatabaseFileName();
  logger.fine("Location of sqlite file: $dbPath");

  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (Database db, int version) async {
      logger.info("Running the migration script v$version...");

      var scripts = (await loadSqlFile(1)).split(";");
      for (var script in scripts) {
        final sql = script
            .trim()
            .replaceAll(RegExp(r"--.*$", multiLine: true), "") // remove comments
            .replaceAll(RegExp(r"\s+"), " "); // squash whitespace
        if (sql.isEmpty) continue;

        logger.fine("Preparing: $sql");
        await db.execute(sql);
      }
    },
  );
}
