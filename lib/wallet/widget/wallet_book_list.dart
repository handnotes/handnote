import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_book.dart';
import 'package:handnote/wallet/widget/wallet_book_item.dart';

class WalletBookList extends HookWidget {
  const WalletBookList(
    this.books, {
    Key? key,
  }) : super(key: key);

  final List<WalletBook> books;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.topLeft,
            child: Text('账本', style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: 8),
          Column(children: [
            for (var asset in books)
              WalletBookItem(
                asset,
                allowEdit: true,
                // trailingBuilder: () => Text(
                //   maskAmount ? '****' : asset.balance.toString(),
                //   style: theme.textTheme.subtitle1,
                // ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => WalletAssetDetailScreen(asset),
                  // ));
                },
              ),
          ]),
        ],
      ),
    );
  }
}
