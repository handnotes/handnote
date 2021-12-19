import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'note.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(max: 50)();

  TextColumn get content => text().withLength(max: 1000)();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get archivedAt => dateTime().nullable()();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("database path: ${dbFolder.path}");
    }
    final file = File(path.join(dbFolder.path, 'note.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Notes])
class NoteDatabase extends _$NoteDatabase {
  NoteDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Note>> watchAll() => (select(notes)..where((n) => n.deletedAt.isNull())).watch();

  Stream<List<Note>> watchAllActivated() =>
      (select(notes)..where((n) => n.deletedAt.isNull() & n.archivedAt.isNull())).watch();

  Stream<List<Note>> watchAllArchived() =>
      (select(notes)..where((n) => n.deletedAt.isNull() & n.archivedAt.isNotNull())).watch();

  Future<List<Note>> getAll() => (select(notes)..where((n) => n.deletedAt.isNull())).get();

  Future<List<Note>> findAllArchivedNotes() =>
      (select(notes)..where((n) => n.deletedAt.isNotNull() & n.archivedAt.isNotNull())).get();

  Future<Note> getOne(int id) => (select(notes)..where((n) => n.id.equals(id))).getSingle();

  Future<int> saveNote(NotesCompanion note) => into(notes).insert(note.copyWith(
        updatedAt: Value(DateTime.now()),
      ));

  Future<bool> deleteNote(Note note) => update(notes).replace(note.copyWith(
        deletedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

  Future<bool> toggleArchive(Note note) => update(notes).replace(note.toCompanion(true).copyWith(
        archivedAt: Value(note.archivedAt == null ? DateTime.now() : null),
        updatedAt: Value(DateTime.now()),
      ));
}
