import 'package:client/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note.dart';

class NoteDetailRouge extends StatelessWidget {
  final Note note;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  NoteDetailRouge({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(note.title.toString()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              _deleteConfirm(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          note.content.toString(),
          style: const TextStyle(height: 1.6),
        ),
      ),
    );
  }

  Future _deleteConfirm(context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(DeleteConfirm.no),
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text('确认要删除这条内容吗', style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                ),
                GestureDetector(
                  child: TextButton(
                    child: const Text('删除', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(context, DeleteConfirm.yes);
                    },
                  ),
                  // onTap: () {
                  //   Navigator.pop(context, DeleteConfirm.yes);
                  // },
                ),
                const TextButton(
                  child: Text('取消', textAlign: TextAlign.center),
                  onPressed: null,
                ),
              ],
            ),
          ),
        );
      },
    );

    switch (result) {
      case DeleteConfirm.yes:
        final db = Provider.of<NoteDatabase>(context, listen: false);
        await db.deleteNote(note);
        Navigator.pop(context);
        break;
      case DeleteConfirm.no:
        break;
    }
  }
}
