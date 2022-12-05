import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handnote/config.dart';
import 'package:handnote/main.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

final logger = Logger('Database');

class DB with ChangeNotifier {
  DB._();

  static final DB shared = DB._();

  static Database? _database;

  bool _isProcessing = false;

  Future<Database> get instance async {
    if (_database != null) return _database!;
    if (_isProcessing) {
      logger.finest('Waiting for instance init...');
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 10));
        if (_database != null) return false;
        return true;
      });
      logger.finest('Found instance...');
      return _database!;
    }
    logger.finest('Init instance...');
    _isProcessing = true;
    _database = await _initDatabase();
    _isProcessing = false;
    logger.finest('Init instance success...');
    return _database!;
  }

  static Future<void> cleanDatabase({BuildContext? context}) async {
    logger.info('Cleaning database...');
    var dbFilename = await _getDatabaseFileName();
    await _database?.close();
    _database = null;
    await deleteDatabase(dbFilename);

    if (context != null) {
      logger.info('Restarting application...');
      HandnoteApp.restartApp(context);
    }
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
    }

    return openDatabase(
      dbPath,
      version: currentDatabaseVersion,
      onOpen: (db) async {
        logger.info('Database opened. Current database version is v${await db.getVersion()}');
      },
      onCreate: (Database db, int version) async {
        logger.info('First time run the app. Start running the migration script to v$version...');
        return _upgradeDatabase(db, 1, version);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        logger.info('Database need to update. Running the migration script v$oldVersion -> v$newVersion...');
        return _upgradeDatabase(db, oldVersion, newVersion);
      },
    );
  }

  Future<void> _upgradeDatabase(Database db, int from, int to) async {
    var i = from;
    try {
      for (; i <= to; i++) {
        await _executeSql(db, i);
      }
      if (from == 1) {
        logger.info('Setup database succeed. Current version: $to');
      } else {
        logger.info('Upgrade database succeed. Current version: $to (old version: $from)');
      }
    } catch (e) {
      logger.severe('Database init failed when run script v$i}');
      rethrow;
    }
  }

  Future<void> _executeSql(Database db, int version) async {
    logger.fine('Executing migration script v$version...');
    var scripts = (await _loadSqlFile(version)).split(';');
    for (var script in scripts) {
      final sql = script
          .replaceAll(RegExp(r'--.*$', multiLine: true), '') // remove comments
          .replaceAll(RegExp(r'\s+'), ' ') // squash whitespace
          .trim();
      if (sql.isEmpty) continue;

      logger.finer('Preparing(v$version): $sql');
      await db.execute(sql);
    }
  }
}
