import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handnote/database.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/logger.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'dart:io';

import 'wallet/constants/wallet_asset_type.dart';
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
