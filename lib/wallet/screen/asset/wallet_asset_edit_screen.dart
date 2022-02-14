import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/widgets/round_icon.dart';

class WalletAssetEditScreen extends HookWidget {
  const WalletAssetEditScreen({Key? key, required this.asset}) : super(key: key);

  final WalletAsset asset;

  bool get isEdit => asset.id != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${isEdit ? '编辑' : '新建'}账户"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Form(
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(asset.name),
                      leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '输入备注名',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      initialValue: asset.remark,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('账户余额'),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        prefixText: '¥',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 22, fontFamily: fontMonospace),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 22, fontFamily: fontMonospace),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
                child: TextButton(
                  child:
                      const Text('保存', style: TextStyle(letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w400)),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red[400],
                    padding: const EdgeInsets.all(24),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
