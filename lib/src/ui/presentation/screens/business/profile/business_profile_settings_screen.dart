import 'package:flutter/material.dart';
import '../../../../../configs/router/routes.dart';

class BusinessProfileSettingsScreen extends StatelessWidget {
  const BusinessProfileSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Business profile')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Center(
            child:
                CircleAvatar(radius: 40, child: Icon(Icons.store, size: 40))),
        Text('ABC General Store',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall),
        const Chip(label: Text('Verified')),
        const Card(
            child: Column(children: [
          ListTile(title: Text('Retail'), subtitle: Text('Category')),
          ListTile(
              title: Text('Lahore · 4 years'),
              subtitle: Text('Location and business age')),
          ListTile(
              title: Text('Business images'),
              subtitle: Text('Storefront and interior')),
          ListTile(
              title: Text('Revenue Rs. 240,000 · Profit Rs. 142,000'),
              subtitle: Text('Performance summary'))
        ])),
        OutlinedButton(
            onPressed: () =>
                Navigator.pushNamed(context, CustomRouter.addBusinessRouteName),
            child: const Text('Edit business')),
        OutlinedButton(onPressed: () {}, child: const Text('Edit profile')),
        const ListTile(leading: Icon(Icons.settings), title: Text('Settings'))
      ]));
}
