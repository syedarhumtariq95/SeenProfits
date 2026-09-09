import 'package:flutter/material.dart';
import '../../../../generics/widgets/buttons/app_primary_button.dart';
import '../../home/performance_chart.dart';

class SeekInvestmentScreen extends StatefulWidget {
  const SeekInvestmentScreen({super.key});
  @override
  State<SeekInvestmentScreen> createState() => _Seek();
}

class _Seek extends State<SeekInvestmentScreen> {
  bool done = false;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Seek investment')),
      body: done
          ? const Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              Text('Opportunity submitted — pending review')
            ]))
          : ListView(padding: const EdgeInsets.all(20), children: [
              ...[
                'Required investment amount',
                'Investment purpose',
                'Description'
              ].map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                      maxLines: item == 'Description' ? 3 : 1,
                      decoration: InputDecoration(
                          labelText: item,
                          border: const OutlineInputBorder())))),
              const PerformanceChart(data: demoPerformance),
              const Card(
                  child: ListTile(
                      title: Text('Performance summary'),
                      subtitle: Text(
                          'Revenue Rs. 240,000 · Expenses Rs. 98,000 · Profit Rs. 142,000'))),
              const Card(
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                          'Disclaimer: Seen Profits does not guarantee returns or participate in investment agreements.'))),
              AppPrimaryButton(
                  label: 'Review & submit',
                  onPressed: () => setState(() => done = true))
            ]));
}
