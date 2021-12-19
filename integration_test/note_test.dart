import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handnote/database.dart';
import 'package:handnote/main.dart';

void main() {
  testWidgets('Note app smoke test', (WidgetTester tester) async {
    cleanDatabase();
    await tester.pumpWidget(const HandnoteApp());

    var addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    await tester.enterText(find.bySemanticsLabel("要记下什么事..."), "abc");

    await tester.tap(find.text("保存"));
    await tester.pumpAndSettle();

    expect(find.text("笔记"), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
