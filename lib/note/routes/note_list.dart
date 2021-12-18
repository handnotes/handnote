import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note.dart';
import 'note_detail.dart';
import 'note_edit.dart';
import 'note_list_archived.dart';

class NoteListRoute extends StatefulWidget {
  const NoteListRoute({Key? key}) : super(key: key);

  @override
  _NoteListRouteState createState() => _NoteListRouteState();
}

class _NoteListRouteState extends State<NoteListRoute> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<NoteDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('日记'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NoteListArchivedList(),
              ));
            },
          )
        ],
      ),
      // bottomNavigationBar: BottomComponent(BottomNav.memo),
      // drawer: HandnoteDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteEditRoute()),
          );
        },
      ),
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
      key: Key('note-${note.id}'),
      direction: DismissDirection.startToEnd,
      child: Container(
        child: ListTile(
          title: note.title.isEmpty ? const Text('(未标题)', style: TextStyle(color: Colors.grey)) : Text(note.title),
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
      confirmDismiss: (direction) async => direction == DismissDirection.startToEnd,
      background: Container(
        child: const Align(
          alignment: FractionalOffset(0.1, 0.5),
          child: Text('归档', style: TextStyle(color: Colors.white)),
        ),
        color: Colors.orangeAccent,
      ),
      onDismissed: (direction) async {
        final db = Provider.of<NoteDatabase>(context);
        await db.toggleArchive(note.toCompanion(true));
      },
    );
  }
}
