import 'package:flutter/material.dart';

import '../../../../../configs/router/routes.dart';
import '../../../../generics/widgets/buttons/app_primary_button.dart';
import '../../home/performance_chart.dart';

/// Canonical routed investor business-detail screen, preserving the existing
/// static detail and interest-sheet interactions.
class InvestorBusinessDetailScreen extends StatelessWidget {
  const InvestorBusinessDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Business detail')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Container(
            height: 145,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.storefront, size: 70)),
        const SizedBox(height: 12),
        Row(children: [
          Text('ABC General Store',
              style: Theme.of(context).textTheme.headlineSmall),
          const Spacer(),
          const Chip(label: Text('Verified'))
        ]),
        const Text('Retail · ★ 4.8 · 2 years · Lahore'),
        const SizedBox(height: 10),
        const Text('A trusted neighborhood store serving the local community.'),
        const Card(
            child: ListTile(
                title: Text('Required investment'),
                subtitle: Text('Rs. 100,000 · Inventory expansion'))),
        const PerformanceChart(data: demoPerformance),
        const Card(
            child: ListTile(
                title: Text('Financial summary'),
                subtitle: Text(
                    'Revenue Rs. 240,000 · Expenses Rs. 98,000 · Profit Rs. 142,000'))),
        AppPrimaryButton(
            label: 'Invest / express interest',
            onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const InterestSheet())),
        OutlinedButton(
            onPressed: () =>
                Navigator.pushNamed(context, CustomRouter.ratingsRouteName),
            child: const Text('Ratings & reviews'))
      ]));
}

class InterestSheet extends StatefulWidget {
  const InterestSheet({super.key});
  @override
  State<InterestSheet> createState() => _InterestSheetState();
}

class _InterestSheetState extends State<InterestSheet> {
  bool sent = false;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(22),
      child: sent
          ? const SizedBox(
              height: 180,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.check_circle, size: 55, color: Colors.green),
                    Text('Interest sent — pending response')
                  ])))
          : Wrap(children: [
              Text('Express interest',
                  style: Theme.of(context).textTheme.headlineSmall),
              const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('ABC General Store'),
                  subtitle:
                      Text('Required Rs. 100,000 · Business age 2 years')),
              const Text('Investment purpose: Inventory expansion'),
              const PerformanceChart(data: demoPerformance, height: 90),
              const Text(
                  'Disclaimer: this is not an investment agreement and returns are not guaranteed.'),
              AppPrimaryButton(
                  label: 'Express Interest',
                  onPressed: () => setState(() => sent = true)),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'))
            ]));
}
