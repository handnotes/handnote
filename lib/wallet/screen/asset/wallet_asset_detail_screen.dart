import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
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
    final scrollController = useScrollController();
    final bankInfo = asset.bank != null ? bankInfoMap[asset.bank] : null;
    final icon = bankInfo != null ? bankInfo.icon : walletAssetTypeIconMap[asset.type];
    final color = icon is SvgIcon
        ? icon.color
        : icon is Icon
            ? icon.color
            : primaryColor;
    final balance = useState(asset.balance);

    final bills = ref.watch(walletBillProvider).where((e) => e.inAssets == asset.id || e.outAssets == asset.id);
    final billMonthly = useMemoized(() => groupBy(bills, (WalletBill e) => '${e.time.year}-${e.time.month}'), [bills]);
    final categories = ref.watch(walletCategoryProvider);
    final categoryMap = useMemoized(() => {for (var e in categories) e.id: e}, [categories]);
    final assets = ref.watch(walletAssetProvider);
    final assetMap = useMemoized(() => {for (var e in assets) e.id: e}, [assets]);

    updateBalance() async {
      if (bills.isEmpty) return;
      balance.value = bills.fold(0.0, (value, element) {
        if (element.inAssets == asset.id) {
          return value + element.amount;
        } else if (element.outAssets == asset.id) {
          return value - element.amount;
        }
        return value;
      });
      if (asset.balance.toStringAsFixed(2) != balance.value.toStringAsFixed(2)) {
        ref.read(walletAssetProvider.notifier).update(asset.copyWith(balance: balance.value));
      }
    }

    useEffect(() {
      updateBalance();
      return null;
    }, [bills]);

    return PageContainer(
      color: color,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0,
          title: const Text('资产详情'),
        ),
        body: CustomScrollView(
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
                  backgroundColor: color,
                  leadingWidth: 72,
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
                  leading: RoundIcon(icon, size: 72, iconSize: 36),
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
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: RoundIcon(
                                Icon(bill.isInner ? FontAwesome.retweet : category?.icon ?? Icons.category),
                                color: billColorMap[bill.type]!,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(bill.isInner ? '内部转账' : category?.name ?? '未分类'),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: '$month月${bill.time.day}日'),
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
                                  if (bill.isInner)
                                    Text(
                                      '${assetMap[bill.outAssets]?.name} > ${assetMap[bill.inAssets]?.name}',
                                      style: theme.textTheme.caption,
                                    )
                                ],
                              ),
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WalletBillEditScreen(bill: bill),
                              )),
                            );
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
    );
  }
}
