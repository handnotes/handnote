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

  testWidgets('Wallet add a asset and delete asset', (WidgetTester tester) async {
    await tester.pumpWidget(const HandnoteApp());

    final addAssetButton = find.bySemanticsLabel('添加资产');
    expect(addAssetButton, findsOneWidget);
    await tester.tap(addAssetButton);
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('支付宝'));
    await tester.pumpAndSettle();

    await tester.enterText(find.bySemanticsLabel('输入备注名'), '我的支付宝');

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(find.text('我的支付宝'), findsOneWidget);

    // delete asset
    await tester.longPress(find.text('我的支付宝'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('删除'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('确认'));
    await tester.pumpAndSettle();

    expect(find.text('我的支付宝'), findsNothing);
  });
}
