import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

final logger = Logger('Database');

class DB with ChangeNotifier {
  DB._();

  static final DB shared = DB._();

  static Database? _database;

  Future<Database> get instance async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<void> cleanDatabase() async {
    logger.info('Cleaning database...');
    await deleteDatabase(await _getDatabaseFileName());
  }

  static Future<String> _getDatabaseFileName() async {
    final dbPath = await getDatabasesPath();
    const dbName = String.fromEnvironment('DB_NAME', defaultValue: 'db.sqlite');
    return path.join(dbPath, dbName);
  }

  Future<String> _loadSqlFile(int version) async {
    return await rootBundle.loadString('assets/migration/sqlite/v$version.sql');
  }

  Future<Database> _initDatabase() async {
    logger.fine('Opening database...');

    var dbPath = await _getDatabaseFileName();
    logger.info('Location of sqlite file: $dbPath');

    if (kDebugMode) {
      Sqflite.setDebugModeOn(true);
      await cleanDatabase();
    }

    return openDatabase(
      dbPath,
      version: 3,
      onCreate: (Database db, int version) async {
        logger.info('First time run the app. Start running the migration script to v$version...');
        for (var i = 1; i <= version; i++) {
          await _executeSql(db, i);
        }
        logger.info('Setup database succeed. Version: $version');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        logger.info('Database need to update. Running the migration script v$oldVersion -> v$newVersion...');
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          await _executeSql(db, oldVersion);
        }
      },
    );
  }

  Future<void> _executeSql(Database db, int version) async {
    logger.fine('Executing migration script v$version...');
    var scripts = (await _loadSqlFile(version)).split(';');
    for (var script in scripts) {
      final sql = script
          .trim()
          .replaceAll(RegExp(r'--.*$', multiLine: true), '') // remove comments
          .replaceAll(RegExp(r'\s+'), ' '); // squash whitespace
      if (sql.isEmpty) continue;

      logger.finer('Preparing(v$version): $sql');
      await db.execute(sql);
    }
  }
}
