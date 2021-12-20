import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../note.dart';
import 'note_detail.dart';

class NoteListArchivedList extends HookWidget {
  const NoteListArchivedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<NoteDatabase>(context);
    final snapshot = useStream(db.watchAllArchived());
    final notes = snapshot.data ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('笔记（已归档）')),
      body: _buildList(context, notes),
    );
  }

  Widget _buildList(BuildContext context, List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(
        child: Text('什么也没有', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final note = notes[index];
        return _buildListItem(context, note);
      },
    );
  }

  Widget _buildListItem(BuildContext context, Note note) {
    return Dismissible(
      key: Key('item-${note.id}'),
      direction: DismissDirection.horizontal,
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
      onDismissed: (direction) async {
        final db = Provider.of<NoteDatabase>(context, listen: false);
        if (direction == DismissDirection.startToEnd) {
          await db.deleteNote(note);
        } else {
          await db.toggleArchive(note);
        }
      },
    );
  }
}
