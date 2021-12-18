import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'note.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  TextColumn get content => text().withLength(max: 1000)();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get archivedAt => dateTime().nullable()();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
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

  Future<List<Note>> getAll() => (select(notes)..where((n) => n.deletedAt.isNull())).get();

  Future<List<Note>> findAllArchivedNotes() =>
      (select(notes)..where((n) => n.deletedAt.isNotNull() & n.archivedAt.isNotNull())).get();

  Future<Note> getOne(int id) => (select(notes)..where((n) => n.id.equals(id))).getSingle();

  Future<int> saveNote(NotesCompanion note) => into(notes).insert(note.copyWith(
        updatedAt: Value(DateTime.now()),
      ));

  Future<int> deleteNote(NotesCompanion note) => update(notes).write(note.copyWith(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ));

  Future<int> toggleArchive(NotesCompanion note) => update(notes).write(note.copyWith(
        archivedAt: Value(note.archivedAt.value == null ? DateTime.now() : null),
        updatedAt: Value(DateTime.now()),
      ));
}
