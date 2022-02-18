import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'wallet/screen/wallet_home_screen.dart';

void main() {
  setupLogger();
  runApp(const HandnoteApp());
}

class HandnoteApp extends StatelessWidget {
  const HandnoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ProviderScope(
      child: MaterialApp(
        title: 'Handnote',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const WalletHomeScreen(),
      ),
    );
  }
}
