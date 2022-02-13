import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';

class WalletAssetEditScreen extends HookWidget {
  const WalletAssetEditScreen({
    Key? key,
    required this.category,
    required this.type,
    this.name,
    this.bank,
  }) : super(key: key);

  final WalletAssetCategory category;
  final WalletAssetType type;
  final String? name;
  final Bank? bank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新建账户'),
      ),
      body: Flexible(
        child: ListView(
          children: const [
            ListTile(
              title: Text('账户名称'),
              subtitle: Text('请输入账户名称'),
              trailing: TextField(
                decoration: InputDecoration(
                  hintText: '请输入账户名称',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
