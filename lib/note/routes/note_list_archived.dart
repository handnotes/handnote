import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note.dart';
import 'note_detail.dart';

class NoteListArchivedList extends StatefulWidget {
  const NoteListArchivedList({Key? key}) : super(key: key);

  @override
  _NoteListArchivedListState createState() => _NoteListArchivedListState();
}

class _NoteListArchivedListState extends State<NoteListArchivedList> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<NoteDatabase>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('日记（已归档）')),
      body: StreamBuilder<List<Note>>(
        stream: db.watchAll(),
        builder: (context, snapshot) {
          final notes = snapshot.data ?? [];
          return _buildList(notes);
        },
      ),
    );
  }

  Widget _buildList(List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(
        child: Text(
          '什么也没有',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final note = notes[index];
        return _buildListItem(note);
      },
    );
  }

  Widget _buildListItem(Note note) {
    return Dismissible(
      key: Key('item-${note.id}'),
      direction: DismissDirection.horizontal,
      child: Container(
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(
            note.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailRouge(note: note),
            ));
          },
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
      ),
      background: Container(
        child: const Align(
          alignment: FractionalOffset(0.1, 0.5),
          child: Text('删除', style: TextStyle(color: Colors.white)),
        ),
        color: Colors.redAccent,
      ),
      secondaryBackground: Container(
        child: const Align(
          alignment: FractionalOffset(0.9, 0.5),
          child: Text('还原', style: TextStyle(color: Colors.white)),
        ),
        color: Colors.green,
      ),
      onDismissed: (direction) async {
        final db = Provider.of<NoteDatabase>(context);
        if (direction == DismissDirection.startToEnd) {
          await db.deleteNote(note.toCompanion(true));
        } else {
          await db.toggleArchive(note.toCompanion(true));
          final archivedNotes = await db.findAllArchivedNotes();
          if (archivedNotes.isEmpty) {
            Navigator.pop(context);
          }
        }
      },
    );
  }
}
