import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

String getDatabaseFileName() {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return 'test.sqlite';
  }
  return 'note.sqlite';
}

LazyDatabase connectDatabase() {
  return LazyDatabase(() async {
    final dbName = getDatabaseFileName();
    final dbFolder = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("database path: ${dbFolder.path}");
    }
    final file = File(path.join(dbFolder.path, dbName));
    return NativeDatabase(file);
  });
}

Future<void> cleanDatabase() async {
  final dbName = getDatabaseFileName();
  final dir = await getApplicationDocumentsDirectory();
  final file = File(path.join(dir.path, dbName));
  await file.delete();
}
