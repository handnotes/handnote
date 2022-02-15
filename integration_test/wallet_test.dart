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
}
