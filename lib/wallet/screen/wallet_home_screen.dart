import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/formatter.dart';

const double bannerHeight = 180;

class WalletHomeScreen extends HookWidget {
  const WalletHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double amount = 1591.0;
    double income = 1;

    final titleOpacity = useState<double>(0);
    final scrollController = useScrollController();
    scrollController.addListener(() {
      titleOpacity.value = scrollController.offset > bannerHeight * 0.6 ? 1 : 0;
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: bannerHeight,
            stretch: true,
            titleSpacing: 0,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: titleOpacity.value,
              child: AppBar(
                title: const Text('Handnote'),
                leading: IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: () {},
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("本月支出（元）", style: TextStyle(fontSize: 14, color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(currencyYuanFormatter.format(amount),
                        style: const TextStyle(fontSize: 32, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text("本月收入 ${income > 0 ? currencyYuanFormatter.format(income) : '暂无收入'} 设置预算",
                        style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              const Text(
                'Welcome to Handnote!',
                style: const TextStyle(fontSize: 20),
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
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Handnote is a decentralized, open-source, and open-source wallet for your digital assets.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use Handnote to store and manage your digital assets, and send them to other people.',
                style: const TextStyle(fontSize: 16),
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
            ]),
          )
        ],
      ),
    );
  }
}
