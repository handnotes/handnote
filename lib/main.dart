import 'package:flutter/material.dart';
import 'package:handnote/note/note.dart';
import 'package:handnote/store.dart';
import 'package:handnote/theme.dart';
import 'package:provider/provider.dart';

import 'note/routes/note_list.dart';

void main() => runApp(const HandnoteApp());

class HandnoteApp extends StatelessWidget {
  const HandnoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppData>.value(value: AppData()),
      ],
      child: Provider(
        create: (_) => NoteDatabase(),
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          color: appTheme.primaryColor,
          child: MaterialApp(
            title: 'Handnote',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            home: const NoteListRoute(),
          ),
        ),
      ),
    );
  }
}
