import 'package:flutter/material.dart';
import 'package:handnote/database.dart';
import 'package:handnote/theme.dart';

void main() => runApp(const HandnoteApp());

class HandnoteApp extends StatelessWidget {
  const HandnoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    connectDatabase();
    return Container(
      padding: const EdgeInsets.only(top: 24),
      color: appTheme.primaryColor,
      child: MaterialApp(
        title: 'Handnote',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: Text("Hello"),
        ),
      ),
    );
  }
}
