import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handnote/database.dart';
import 'package:handnote/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    cleanDatabase();
  });

  testWidgets('Add note', (WidgetTester tester) async {
    await tester.pumpWidget(const HandnoteApp());

    final addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    await tester.enterText(find.bySemanticsLabel("要记下什么事..."), "abc");

    await tester.tap(find.text("保存"));
    await tester.pumpAndSettle();

    expect(find.text("笔记"), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    await tester.tap(find.byIcon(Icons.archive));
    await tester.pumpAndSettle();

    expect(find.textContaining("已归档"), findsOneWidget);

    await tester.tap(find.text("abc"));
    await tester.pumpAndSettle();

    expect(find.textContaining("abc"), findsOneWidget);

    await tester.tap(find.bySemanticsLabel("Back"));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Dismissible), const Offset(500, 0));
  });
}
