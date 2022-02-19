import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handnote/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // clean db
  });

  testWidgets('Wallet can mask income and outcome value', (WidgetTester tester) async {
    await tester.pumpWidget(const HandnoteApp());

    expect(find.textContaining('本月支出'), findsOneWidget);
    expect(find.textContaining('1,591.00'), findsOneWidget);

    final maskButton = find.byIcon(Ionicons.eye);
    expect(maskButton, findsOneWidget);

    await tester.tap(maskButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('****'), findsWidgets);
  });

  testWidgets('Wallet asset add / edit / delete test', (WidgetTester tester) async {
    const assetName = '支付宝';
    const assetRemark = '我的支';
    const assetRemarkUpdated = '我的宝';

    await tester.pumpWidget(const HandnoteApp());

    // create asset
    final addAssetButton = find.bySemanticsLabel('添加资产');
    expect(addAssetButton, findsOneWidget);
    await tester.tap(addAssetButton);
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining(assetName));
    await tester.pumpAndSettle();

    var remarkField = find.bySemanticsLabel('备注名');
    await tester.tap(remarkField);
    await tester.pumpAndSettle();
    await tester.enterText(remarkField, assetRemark);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(find.textContaining(assetRemark), findsOneWidget);

    // edit asset
    await tester.longPress(find.textContaining(assetRemark));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.tapAt(tester.getTopLeft(find.byType(Dialog), warnIfMissed: true, callee: 'tap'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.longPress(find.textContaining(assetRemark));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.bySemanticsLabel('编辑'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(find.textContaining(assetName), findsOneWidget);
    expect(find.textContaining(assetRemark), findsOneWidget);

    remarkField = find.bySemanticsLabel('备注名');
    await tester.tap(remarkField);
    await tester.pumpAndSettle();
    await tester.enterText(remarkField, assetRemarkUpdated);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(find.bySemanticsLabel('账户余额'), '100.01');
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.bySemanticsLabel('保存'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    final assetUpdatedWidget = find.widgetWithText(ListTile, assetRemarkUpdated);
    expect(assetUpdatedWidget, findsOneWidget);
    final balanceText = find.descendant(of: assetUpdatedWidget, matching: find.textContaining('100.01'));
    expect(balanceText, findsOneWidget);

    // delete asset
    // TODO: cannot reopen dialog with long press (https://github.com/flutter/flutter/issues/98804)
    // await tester.longPress(balanceText);
    // await tester.pumpAndSettle();
    // await tester.pump(const Duration(seconds: 1));
    // await tester.tap(find.bySemanticsLabel('删除'));
    // await tester.pumpAndSettle();
    // await tester.tap(find.bySemanticsLabel('确认'));
    // await tester.pumpAndSettle();
    //
    // expect(find.text(assetRemarkUpdated), findsNothing);
  });
}
