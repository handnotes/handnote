import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../note.dart';

class NoteEditRoute extends HookWidget {
  const NoteEditRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();

    onSave() {
      final title = titleController.value.text;
      final content = contentController.value.text;

      if (title.isNotEmpty || content.isNotEmpty) {
        // 存储新的备忘
        final note = NotesCompanion.insert(
          title: title,
          content: content,
        );
        final db = Provider.of<NoteDatabase>(context, listen: false);
        db.saveNote(note);
        titleController.clear();
        contentController.clear();
      }

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('随手记'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                key: const Key('title'),
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: '标题(选填)',
                ),
              ),
              TextFormField(
                key: const Key('content'),
                maxLines: 10,
                autofocus: true,
                controller: contentController,
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
                  child: const Text('保存', style: TextStyle(color: Colors.white)),
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
