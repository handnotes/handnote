import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_add_screen.dart';
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
    scrollController.addListener(() {
      titleOpacity.value = scrollController.offset > bannerHeight * 0.7 ? 1 : 0;
    });

    useEffect(() {
      ref.read(walletAssetProvider.notifier).getList();
      return null;
    }, []);

    final walletAssets = ref.watch(walletAssetProvider);

    return PageContainer(
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            _appBar(context, titleOpacity, maskAmount),
            SliverList(
              delegate: SliverChildListDelegate([
                _addABillWidget(context),
                WalletAssetList(walletAssets, maskAmount: maskAmount.value),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ValueNotifier<double> titleOpacity, ValueNotifier<bool> maskAmount) {
    double outcome = 1591.0;
    double income = 1;
    double budget = 10000;

    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.apply(
          bodyColor: theme.colorScheme.onPrimaryContainer,
          displayColor: theme.colorScheme.onPrimaryContainer,
        ),
        iconTheme: theme.iconTheme.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return SliverAppBar(
          toolbarHeight: kToolbarHeight - 12,
          pinned: true,
          expandedHeight: bannerHeight,
          stretch: true,
          titleSpacing: 0,
          title: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: titleOpacity.value),
            duration: const Duration(milliseconds: 300),
            builder: (context, opacity, _) => AppBar(
              title: Text('Handnote', style: TextStyle(color: Colors.white.withOpacity(opacity))),
              primary: false,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.book),
                iconSize: 20,
                onPressed: () {
                  // TODO: goto account book page
                },
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('本月支出', style: theme.textTheme.subtitle1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CurrencyText(
                          outcome,
                          mask: maskAmount.value,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      IconButton(
                        onPressed: () => maskAmount.value = !maskAmount.value,
                        icon: maskAmount.value ? const Icon(Ionicons.eye_off) : const Icon(Ionicons.eye),
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
                              Text('本月收入', style: theme.textTheme.bodyText2),
                              const SizedBox(width: 8),
                              maskAmount.value
                                  ? CurrencyText(income, mask: true)
                                  : income > 0
                                      ? CurrencyText(income)
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
                              ? Row(
                                  children: const [
                                    Text('设置预算'),
                                    SizedBox(width: 8),
                                    Icon(Icons.admin_panel_settings_outlined, size: 18),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(budget - outcome > 0 ? '预算剩余' : '预算超支'),
                                    const SizedBox(width: 8),
                                    CurrencyText((budget - outcome).abs(), mask: maskAmount.value),
                                  ],
                                ),
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
        shadowColor: theme.colorScheme.secondary.withOpacity(0.5),
        child: Container(
          color: theme.colorScheme.secondary,
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: TextButton.icon(
                  label: Text(
                    '记一笔',
                    style: theme.textTheme.headline6?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                  ),
                  icon: Icon(
                    Fontisto.plus_a,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: theme.textTheme.headline6?.fontSize,
                  ),
                  onPressed: () {
                    // TODO: add a bill page
                  },
                ),
              ),
              const SizedBox(height: 28, child: VerticalDivider(color: Colors.white54, width: 0)),
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
}
