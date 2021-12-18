import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note.dart';

class NoteEditRoute extends StatefulWidget {
  const NoteEditRoute({Key? key}) : super(key: key);

  @override
  _NoteEditRouteState createState() => _NoteEditRouteState();
}

class _NoteEditRouteState extends State<NoteEditRoute> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('随手记'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: '标题(选填)',
                ),
              ),
              TextFormField(
                maxLines: 10,
                autofocus: true,
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: '要记下什么事...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  child: const Text(
                    '保存',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    final title = _titleController.value.text;
                    final content = _contentController.value.text;

                    if (title.isNotEmpty || content.isNotEmpty) {
                      // 存储新的备忘
                      final note = NotesCompanion.insert(
                        title: title,
                        content: content,
                      );
                      final db = Provider.of<NoteDatabase>(context, listen: false);
                      db.saveNote(note);
                      _titleController.clear();
                      _contentController.clear();
                    }

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
