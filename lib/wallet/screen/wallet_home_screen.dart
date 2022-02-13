import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/widgets/currency_text.dart';

const double bannerHeight = 180;

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
              _addABillWidget(),
              _accountListWidget(),
              _accountListWidget(),
              _accountListWidget(),
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

  Widget _addABillWidget() {
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
              const SizedBox(height: 28, child: VerticalDivider(color: Colors.white54)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  child: const Text(
                    "添加资产",
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    // TODO: add asset page
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountListWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.topLeft,
            child: const Text("账户", style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              _accountItemWidget(0),
              _accountItemWidget(1),
              _accountItemWidget(2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountItemWidget(int index) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet, size: 28),
        title: Text("账户$index", style: const TextStyle(fontSize: 16)),
        subtitle: Text("账户$index", style: const TextStyle(fontSize: 14)),
        trailing: Text("账户$index", style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
