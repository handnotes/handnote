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
    final scrollController = useScrollController();
    scrollController.addListener(() {
      titleOpacity.value = scrollController.offset > bannerHeight * 0.7 ? 1 : 0;
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          _appBar(titleOpacity),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              const Text(
                'Welcome to Handnote!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a simple, secure, and easy-to-use wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget _appBar(ValueNotifier<double> titleOpacity) {
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
              CurrencyText(outcome, fontSize: 32),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: income page
                      },
                      child: _incomeWidget(income),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: setup budget page
                      },
                      child: _budgetWidget(budget, outcome),
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

  Widget _incomeWidget(double income) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("本月收入", style: TextStyle(fontSize: 14, color: Colors.white70)),
        const SizedBox(width: 8),
        income > 0
            ? CurrencyText(income, fontSize: 14)
            : const Text("暂无收入", style: TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }

  Widget _budgetWidget(double budget, double outcome) {
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
              CurrencyText((budget - outcome).abs(), fontSize: 14),
            ],
          );
  }
}
