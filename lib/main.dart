import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/logger.dart';
import 'package:handnote/wallet/screen/wallet_home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  setupLogger();
  runApp(const HandnoteApp());
}

class HandnoteApp extends StatefulWidget {
  const HandnoteApp({Key? key}) : super(key: key);

  static restartApp(BuildContext context) {
    context.findAncestorStateOfType<_HandnoteAppState>()?.restart();
  }

  @override
  State<HandnoteApp> createState() => _HandnoteAppState();
}

class _HandnoteAppState extends State<HandnoteApp> {
  Key key = UniqueKey();

  void restart() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Container(
      key: key,
      child: ProviderScope(
        child: MaterialApp(
          title: 'Handnote',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: const WalletHomeScreen(),
        ),
      ),
    );
  }
}
