import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/formatter.dart';

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
    double amount = 1591.0;
    double income = 1;

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
              const SizedBox(height: 8),
              Text(currencyYuanFormatter.format(amount), style: const TextStyle(fontSize: 32, color: Colors.white)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text("本月收入\t${income > 0 ? currencyYuanFormatter.format(income) : '暂无收入'}",
                        style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  ),
                  Expanded(child: _setupBudgetWidget()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setupBudgetWidget() {
    return GestureDetector(
      onTap: () {
        // TODO: setup budget page
      },
      child: Row(
        children: const [
          Text("设置预算", style: TextStyle(fontSize: 14, color: Colors.white70)),
          SizedBox(width: 8),
          Icon(Icons.admin_panel_settings_outlined, color: Colors.white70, size: 18),
        ],
      ),
    );
  }
}
