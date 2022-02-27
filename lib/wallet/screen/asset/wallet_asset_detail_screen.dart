import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/constants/enums.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/formatter.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/constants/wallet_system_category.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/screen/bill/wallet_bill_edit_screen.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:handnote/widgets/svg_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetDetailScreen extends HookConsumerWidget {
  const WalletAssetDetailScreen(
    this.asset, {
    Key? key,
  }) : super(key: key);

  final WalletAsset asset;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final tapPosition = useState<Offset?>(null);
    final scrollController = useScrollController();
    final bankInfo = asset.bank != null ? bankInfoMap[asset.bank] : null;
    final icon = bankInfo != null ? bankInfo.icon : walletAssetTypeIconMap[asset.type];
    Color color = (icon is SvgIcon
        ? icon.color
        : icon is Icon
            ? icon.color
            : primaryColor)!;

    if (theme.brightness == Brightness.dark) {
      color = Color.alphaBlend(color.withOpacity(0.6), Colors.grey[900]!);
    }

    final balance = useState(asset.balance);

    final bills = ref.watch(walletBillProvider).where((e) => e.inAssets == asset.id || e.outAssets == asset.id);
    final billMonthly = useMemoized(() => groupBy(bills, (WalletBill e) => '${e.time.year}-${e.time.month}'), [bills]);
    final categories = ref.watch(walletCategoryProvider);
    final categoryMap = useMemoized(() => {for (var e in categories) e.id: e}, [categories]);
    final assets = ref.watch(walletAssetProvider);
    final assetMap = useMemoized(() => {for (var e in assets) e.id: e}, [assets]);

    useEffect(() {
      ref
          .read(walletAssetProvider.notifier)
          .reloadBalance(asset.id, originalBalance: asset.balance)
          .then((value) => balance.value = value);
      return null;
    }, []);

    return PageContainer(
      color: color,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0,
          title: const Text('资产详情'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  Theme(
                    data: theme.copyWith(
                      textTheme: theme.textTheme.copyWith(
                        headline6: theme.textTheme.headline6?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    child: Builder(builder: (context) {
                      final theme = Theme.of(context);
                      return SliverAppBar(
                        toolbarHeight: kToolbarHeight,
                        expandedHeight: 160,
                        collapsedHeight: 64,
                        leadingWidth: 72,
                        backgroundColor: color,
                        titleSpacing: 0,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(asset.name, style: theme.textTheme.headline6),
                            const SizedBox(width: 16),
                            if (asset.subtitle != null) Text(asset.subtitle!),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '¥ ${balance.value.toStringAsFixed(2)}',
                                style: theme.textTheme.headline6?.copyWith(
                                  fontFamily: fontMonospace,
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: RoundIcon(icon, size: 72, iconSize: 36, color: color),
                        stretch: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(color: color),
                        ),
                      );
                    }),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      for (final yearMonth in billMonthly.keys) ...[
                        Builder(builder: (context) {
                          final bills = billMonthly[yearMonth]!;
                          final year = int.parse(yearMonth.split('-')[0]);
                          final month = int.parse(yearMonth.split('-')[1]);
                          return ExpansionTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$month月', style: theme.textTheme.subtitle1),
                                Text('$year年', style: theme.textTheme.caption),
                              ],
                            ),
                            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            controlAffinity: ListTileControlAffinity.leading,
                            children: [
                              for (final bill in bills) ...[
                                const Divider(height: 1),
                                Builder(builder: (context) {
                                  final category = categoryMap[bill.category];
                                  return _buildItem(context, bill, category, assetMap, tapPosition, ref, balance);
                                })
                              ],
                            ],
                          );
                        }),
                        const Divider(height: 1),
                      ],
                    ]),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              child: const Text('记一笔'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 0, color: theme.dividerColor),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WalletBillEditScreen(
                    bill: WalletBill(outAssets: asset.id),
                  ),
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    WalletBill bill,
    WalletCategory? category,
    Map<int?, WalletAsset> assetMap,
    ValueNotifier<Offset?> tapPosition,
    WidgetRef ref,
    ValueNotifier<double> balance,
  ) {
    final theme = Theme.of(context);
    final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();

    return GestureDetector(
      onTapDown: (details) => tapPosition.value = details.globalPosition,
      onLongPress: () async {
        // A context menu can delete the bill.
        final action = await showMenu<MenuAction>(
          context: context,
          position: RelativeRect.fromRect(
            tapPosition.value! & const Size(40, 40),
            Offset.zero & overlay!.semanticBounds.size,
          ),
          items: [
            const PopupMenuItem(child: Text('删除'), value: MenuAction.delete),
          ],
        );
        // ignore: missing_enum_constant_in_switch
        switch (action) {
          case MenuAction.delete:
            await ref.read(walletBillProvider.notifier).delete(bill);
            balance.value = await ref.read(walletAssetProvider.notifier).reloadBalance(bill.inAssets);
            break;
        }
      },
      child: bill.category == walletSystemCategoryIdMap[WalletSystemCategory.adjustBalance]
          ? ListTile(
              leading: const RoundIcon(Icon(Icons.money_off_csred_rounded)),
              title: const Text('余额调整'),
              subtitle: Text('余额调整为 ¥${bill.inAmount.toStringAsFixed(2)}'),
              trailing: Text(monthDayFormatCn.format(bill.time), style: theme.textTheme.caption),
              onTap: () {},
            )
          : ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: RoundIcon(
                Icon(bill.isInnerTransfer ? FontAwesome.retweet : category?.icon ?? Icons.category),
                color: billColorMap[bill.type]!,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bill.isInnerTransfer ? '内部转账' : category?.name ?? '未分类'),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    text: TextSpan(
                      children: [
                        TextSpan(text: monthDayFormatCn.format(bill.time)),
                        TextSpan(
                          text: ' ${bill.description} ${bill.counterParty}',
                          style: TextStyle(color: theme.disabledColor),
                        ),
                      ],
                      style: theme.textTheme.caption,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '¥ ${bill.amount.toStringAsFixed(2)}',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: billColorMap[bill.type]!,
                    ),
                  ),
                  if (bill.isInnerTransfer)
                    Text(
                      '${assetMap[bill.outAssets]?.name ?? '未选择'} > ${assetMap[bill.inAssets]?.name ?? '未选择'}',
                      style: theme.textTheme.caption,
                    )
                ],
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WalletBillEditScreen(bill: bill),
              )),
            ),
    );
  }
}
