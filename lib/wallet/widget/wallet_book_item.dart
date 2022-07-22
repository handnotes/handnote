import 'package:flutter/material.dart';
import 'package:handnote/wallet/model/wallet_book.dart';
import 'package:handnote/wallet/model/wallet_book_provider.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBookItem extends HookConsumerWidget {
  const WalletBookItem(
    this.book, {
    Key? key,
    this.dense = false,
    this.trailingBuilder,
    this.onTap,
    this.allowEdit = false,
  }) : super(key: key);

  final WalletBook? book;
  final bool dense;
  final Widget? Function()? trailingBuilder;
  final GestureTapCallback? onTap;
  final bool allowEdit;

  @override
  Widget build(BuildContext context, ref) {
    return dense
        ? _buildListTile(context, ref, book)
        : Card(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.1),
            child: _buildListTile(context, ref, book),
          );
  }

  ListTile _buildListTile(BuildContext context, WidgetRef ref, WalletBook? book) {
    final theme = Theme.of(context);
    final bookIcon = book == null
        ? RoundIcon(
            const Icon(Icons.account_balance_wallet),
            color: theme.disabledColor,
          )
        : null;

    return ListTile(
      minVerticalPadding: 0,
      leading: FittedBox(
        alignment: Alignment.centerLeft,
        child: bookIcon,
      ),
      title: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book?.name ?? '选择账户',
              style: theme.textTheme.subtitle1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
      trailing: trailingBuilder != null ? trailingBuilder!() : null,
      onTap: onTap,
      onLongPress: allowEdit && book != null ? () => _showAdvancedDialog(context, ref) : null,
    );
  }

  Future<int?> _showAdvancedDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              bodyText2: theme.textTheme.bodyText2?.copyWith(fontSize: 16),
            ),
          ),
          child: SimpleDialog(
            title: Text(book!.name),
            children: [
              SimpleDialogOption(
                child: const Text('编辑'),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onPressed: () => _editBook(context, ref),
              ),
              SimpleDialogOption(
                child: const Text('删除'),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onPressed: () => _deleteBook(context, ref),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editBook(BuildContext context, WidgetRef ref) async {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => WalletBookEditScreen(book: book!),
    // ));
  }

  Future<void> _deleteBook(BuildContext context, WidgetRef ref) async {
    // TODO: determine if book is have billing
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确认删除资产：${book!.name}？'),
        actions: [
          TextButton(
            autofocus: true,
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            child: const Text('确认'),
            onPressed: () async {
              await ref.read(walletBookProvider.notifier).delete(book!);
              Navigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        ],
      ),
    );
  }
}
