import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handnote/database.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/logger.dart';
import 'dart:io';

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
    final double padding = Platform.isMacOS ? 24 : 0;

    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Container(
      padding: EdgeInsets.only(top: padding),
      color: appTheme.primaryColor,
      child: MaterialApp(
        title: 'Handnote',
        theme: appTheme,
        home: const WalletHomeScreen(),
      ),
    );
  }
}
