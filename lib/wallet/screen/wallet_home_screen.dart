import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/enum/wallet_asset_category.dart';
import 'package:handnote/wallet/enum/wallet_asset_type.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_add_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_list.dart';
import 'package:handnote/widgets/currency_text.dart';

const double bannerHeight = 180;
final List<WalletAsset> walletAssets = [
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.cash, name: '现金钱包', remark: '', balance: 100.0),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.creditCard, name: '建设银行', cardNumber: '3759'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, name: '农业银行', remark: '房贷卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, name: '招商银行', remark: '工资卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.alipay, name: '支付宝'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.wechat, name: '微信钱包'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.livingCard, name: '饭卡', remark: '关东即时捞'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.livingCard, name: '购物卡', remark: '盒马鲜生'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.livingCard, name: '购物卡', remark: '蛋糕先生'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.livingCard, name: '公交卡', remark: '天府通'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.haircutCard, name: '剪发卡', remark: 'TAT'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, name: '数字人民币'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, name: 'Steam'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.reimburse, name: 'Thoughtworks'),
  WalletAsset(
      category: WalletAssetCategory.payable,
      type: WalletAssetType.borrowIn,
      name: '蚂蚁花呗',
      remark: '花呗',
      initAmount: 2000),
  WalletAsset(
      category: WalletAssetCategory.payable,
      type: WalletAssetType.loan,
      name: '成都市公积金',
      remark: '住房公积金贷款',
      notCounted: true,
      showInHomePage: false),
  WalletAsset(
      category: WalletAssetCategory.payable,
      type: WalletAssetType.loan,
      name: '农业银行',
      remark: '住房贷款',
      notCounted: true),
];

class WalletHomeScreen extends HookWidget {
  const WalletHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleOpacity = useState<double>(0);
    final maskAmount = useState(false);
    final scrollController = useScrollController();
    scrollController.addListener(() {
      titleOpacity.value = scrollController.offset > bannerHeight * 0.7 ? 1 : 0;
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          _appBar(titleOpacity, maskAmount),
          SliverList(
            delegate: SliverChildListDelegate([
              _addABillWidget(context),
              WalletAssetList(walletAssets, maskAmount: maskAmount.value),
            ]),
          )
        ],
      ),
    );
  }

  Widget _appBar(ValueNotifier<double> titleOpacity, ValueNotifier<bool> maskAmount) {
    double outcome = 1591.0;
    double income = 1;
    double budget = 10000;

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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("本月支出（元）", style: TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: CurrencyText(outcome, mask: maskAmount.value, fontSize: 32)),
                  IconButton(
                    onPressed: () {
                      maskAmount.value = !maskAmount.value;
                    },
                    icon: maskAmount.value
                        ? const Icon(Icons.visibility_off, color: Colors.white)
                        : const Icon(Icons.visibility, color: Colors.white),
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
                      child: _incomeWidget(income, maskAmount),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: setup budget page
                      },
                      child: _budgetWidget(budget, outcome, maskAmount),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incomeWidget(double income, ValueNotifier<bool> maskAmount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("本月收入", style: TextStyle(fontSize: 14, color: Colors.white70)),
        const SizedBox(width: 8),
        maskAmount.value
            ? CurrencyText(income, mask: true, fontSize: 14)
            : income > 0
                ? CurrencyText(income, fontSize: 14)
                : const Text("暂无收入", style: TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }

  Widget _budgetWidget(double budget, double outcome, ValueNotifier<bool> maskAmount) {
    return budget == 0
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("设置预算", style: TextStyle(fontSize: 14, color: Colors.white70)),
              SizedBox(width: 8),
              Icon(Icons.admin_panel_settings_outlined, color: Colors.white70, size: 18),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(budget - outcome > 0 ? "预算剩余" : "预算超支", style: const TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(width: 8),
              CurrencyText((budget - outcome).abs(), mask: maskAmount.value, fontSize: 14),
            ],
          );
  }

  Widget _addABillWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.red.withOpacity(0.5),
        child: Container(
          color: Colors.red[400],
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: TextButton.icon(
                  label: const Text(
                    "记一笔",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 28),
                  onPressed: () {
                    // TODO: add a bill page
                  },
                ),
              ),
              const SizedBox(height: 28, child: VerticalDivider(color: Colors.white54, width: 0)),
              TextButton(
                child: const Text(
                  "添加资产",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
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
