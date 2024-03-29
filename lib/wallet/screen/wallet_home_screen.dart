import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/icons.dart';
import 'package:handnote/database/common_data.dart';
import 'package:handnote/database/common_data_provider.dart';
import 'package:handnote/database/db.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_add_screen.dart';
import 'package:handnote/wallet/screen/bill/wallet_bill_edit_screen.dart';
import 'package:handnote/wallet/screen/bill/wallet_bill_import_screen.dart';
import 'package:handnote/wallet/screen/category/wallet_category_manage_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_list.dart';
import 'package:handnote/widgets/currency_text.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double bannerHeight = 180;

class WalletHomeScreen extends HookConsumerWidget {
  const WalletHomeScreen({Key? key}) : super(key: key);

  static const routeName = '/wallet';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleOpacity = useState<double>(0);
    final maskAmount = useState(false);
    final scrollController = useScrollController();
    final commonData = ref.watch(commonDataProvider);

    useEffect(() {
      ref.read(commonDataProvider.notifier).loadData();
      ref.read(walletAssetProvider.notifier).loadData();

      ref.read(walletBillProvider.notifier).loadData().then((value) {
        _updateTotalBalance(ref);
      });
      ref.read(walletCategoryProvider.notifier).getList();

      scrollController.addListener(() {
        titleOpacity.value = scrollController.offset > bannerHeight * 0.7 ? 1 : 0;
      });
    }, []);

    final walletAssets = ref.watch(walletAssetProvider).where((e) => e.showInHomePage).toList();
    final totalBalance = useMemoized(
      () => walletAssets.fold<double>(0, (previous, asset) => previous + asset.balance),
      [walletAssets],
    );

    useEffect(() {
      _updateTotalBalance(ref);
    }, [totalBalance]);

    return PageContainer(
      child: Scaffold(
        drawer: _buildDrawer(context),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            _buildAppBar(context, titleOpacity, maskAmount, commonData),
            SliverList(
              delegate: SliverChildListDelegate([
                _addABillWidget(context),
                // WalletBookList([]),
                WalletAssetList(walletAssets, maskAmount: maskAmount.value),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text('Handnote Wallet'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('分类管理'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WalletCategoryManageScreen(),
            )),
          ),
          ListTile(
            leading: const Icon(FontAwesome5Solid.file_import),
            title: const Text('导入账单'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WalletBillImportScreen(),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('清除数据'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('清除数据'),
                    content: const Text('清除后将回回到初始状态，确定要清空数据吗？'),
                    buttonPadding: const EdgeInsets.all(24),
                    actions: [
                      TextButton.icon(
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('重置数据库'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          primary: errorColor,
                        ),
                        onPressed: () => DB.cleanDatabase(context: context),
                      ),
                      TextButton(
                        child: const Text('取消'),
                        autofocus: true,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    ValueNotifier<double> titleOpacity,
    ValueNotifier<bool> maskAmount,
    CommonData commonData,
  ) {
    final double income = commonData.walletLatest30dIncome;
    final double outcome = commonData.walletLatest30dOutcome;
    const double budget = 10000;

    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.apply(
          bodyColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
          displayColor: theme.colorScheme.onPrimaryContainer,
        ),
        iconTheme: theme.iconTheme.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return SliverAppBar(
          backgroundColor: theme.colorScheme.primaryContainer,
          toolbarHeight: kToolbarHeight - 12,
          pinned: true,
          expandedHeight: bannerHeight,
          stretch: true,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: titleOpacity.value),
            duration: const Duration(milliseconds: 300),
            builder: (context, opacity, _) => AppBar(
              title: Text(
                'Handnote',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer.withOpacity(opacity)),
              ),
              primary: false,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('近30天支出', style: theme.textTheme.subtitle1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: outcome, end: outcome),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, value, _) {
                              return CurrencyText(
                                value as double,
                                mask: maskAmount.value,
                                style: theme.textTheme.headline4,
                              );
                            }),
                      ),
                      IconButton(
                        onPressed: () => maskAmount.value = !maskAmount.value,
                        icon: maskAmount.value
                            ? Icon(systemIcon['eye-close'], color: Colors.white, size: 20)
                            : const Icon(Ionicons.eye),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: income page
                          },
                          child: Row(
                            children: [
                              Text('近30天收入', style: theme.textTheme.bodyText2),
                              const SizedBox(width: 8),
                              maskAmount.value
                                  ? CurrencyText(income, mask: true)
                                  : income > 0
                                      ? TweenAnimationBuilder(
                                          tween: Tween<double>(begin: income, end: income),
                                          duration: const Duration(milliseconds: 500),
                                          builder: (context, value, _) => CurrencyText(value as double),
                                        )
                                      : Text('暂无收入', style: theme.textTheme.bodyText2),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: setup budget page
                          },
                          child: budget == 0
                              ? Row(children: const [
                                  Text('设置预算'),
                                  SizedBox(width: 8),
                                  Icon(Icons.admin_panel_settings_outlined, size: 18),
                                ])
                              : Row(children: [
                                  Text(budget - outcome > 0 ? '预算剩余' : '预算超支'),
                                  const SizedBox(width: 8),
                                  CurrencyText((budget - outcome).abs(), mask: maskAmount.value),
                                ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _addABillWidget(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAlias,
        shadowColor: theme.colorScheme.secondaryContainer.withOpacity(0.4),
        child: Container(
          color: theme.colorScheme.secondaryContainer,
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: TextButton.icon(
                  icon: Icon(
                    Fontisto.plus_a,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: theme.textTheme.headline6?.fontSize,
                  ),
                  label: Text(
                    '记一笔',
                    style: theme.textTheme.headline6?.copyWith(color: theme.colorScheme.onSecondaryContainer),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WalletBillEditScreen(isEdit: false),
                    ));
                  },
                ),
              ),
              const VerticalDivider(width: 0),
              TextButton(
                child: Text(
                  '添加资产',
                  style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletAssetAddScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTotalBalance(WidgetRef ref) {
    final bills = ref
        .read(walletBillProvider)
        .where(
          (bill) =>
              (bill.category ?? 0) >= 0 &&
              bill.time.isAfter(
                DateTime.now().subtract(const Duration(days: 30)),
              ),
        )
        .toList();
    final income = bills.fold<double>(0, (income, bill) => income + bill.inAmount);
    final outcome = bills.fold<double>(0, (outcome, bill) => outcome + bill.outAmount);
    ref.read(commonDataProvider.notifier).save({
      CommonDataKey.walletLatest30dIncome: income.toString(),
      CommonDataKey.walletLatest30dOutcome: outcome.toString(),
    });
  }
}
