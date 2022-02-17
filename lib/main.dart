import 'dart:io';

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
    final double padding = Platform.isMacOS ? 24 : 0;

    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ProviderScope(
      child: Container(
        padding: EdgeInsets.only(top: padding),
        color: appTheme.primaryColor,
        child: MaterialApp(
          title: 'Handnote',
          theme: appTheme,
          home: const WalletHomeScreen(),
        ),
      ),
    );
  }
}
