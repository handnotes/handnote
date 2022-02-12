import 'package:flutter/material.dart';
import 'package:handnote/database.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/logger.dart';

import 'wallet/screen/wallet_home_screen.dart';

void main() {
  setupLogger();
  runApp(const HandnoteApp());
}

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
        home: const WalletHomeScreen(),
      ),
    );
  }
}
