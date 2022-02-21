import 'package:flutter/material.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/round_icon.dart';

class WalletAssetSelectBankScreen extends StatelessWidget {
  const WalletAssetSelectBankScreen({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final WalletAsset asset;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('选择${asset.type == WalletAssetType.creditCard ? "信用卡" : "储蓄卡"}发卡行'),
        ),
        body: ListView.builder(
          itemCount: Bank.values.length,
          itemBuilder: (context, index) {
            final bankInfo = bankInfoMap[Bank.values[index]]!;
            return Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                ),
              ),
              child: ListTile(
                title: Text(bankInfo.name),
                leading: RoundIcon(bankInfo.icon),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WalletAssetEditScreen(
                        asset: asset.copyWith(bank: bankInfo.bank),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
