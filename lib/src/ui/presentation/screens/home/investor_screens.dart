import 'package:flutter/material.dart';
import '../../../../configs/router/routes.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';

class InvestorProfileScreen extends StatelessWidget {
  const InvestorProfileScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Investor profile')),
      body: ListView(children: [
        const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
        const ListTile(
            title: Text('Ali Raza'),
            subtitle: Text('Preferred: Retail, Services')),
        ListTile(
            onTap: () => Navigator.pushNamed(c, CustomRouter.ratingsRouteName),
            title: const Text('Ratings & reviews')),
        ListTile(
            onTap: () => Navigator.pushNamed(c, CustomRouter.settingsRouteName),
            title: const Text('Settings'))
      ]));
}

class InvestorRequestsScreen extends StatefulWidget {
  const InvestorRequestsScreen({super.key});
  @override
  State<InvestorRequestsScreen> createState() => _InvestorRequests();
}

class _InvestorRequests extends State<InvestorRequestsScreen> {
  final rows = [
    ['ABC General Store', 'Rs. 100,000', 'Pending'],
    ['XYZ Restaurant', 'Rs. 250,000', 'Negotiating'],
    ['Green Care Services', 'Rs. 75,000', 'Completed']
  ];
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Investment requests')),
      body: ListView(
          children: rows
              .map((r) => ListTile(
                  onTap: () => showModalBottomSheet(
                      context: c,
                      builder: (ctx) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(children: [
                            Text(r[0], style: Theme.of(c).textTheme.titleLarge),
                            Text('${r[1]} · ${r[2]} · 12 Sep 2026'),
                            if (r[2] == 'Pending')
                              OutlinedButton(
                                  onPressed: () {
                                    setState(() => r[2] = 'Cancelled');
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Cancel request')),
                            OutlinedButton(
                                onPressed: () => Navigator.pushNamed(
                                    c, CustomRouter.chatRouteName),
                                child: const Text('Chat'))
                          ]))),
                  title: Text(r[0]),
                  subtitle: Text('${r[1]} · 12 Sep 2026'),
                  trailing: Chip(label: Text(r[2]))))
              .toList()));
}

class RatingsReviewsScreen extends StatefulWidget {
  const RatingsReviewsScreen({super.key});
  @override
  State<RatingsReviewsScreen> createState() => _Ratings();
}

class _Ratings extends State<RatingsReviewsScreen> {
  int star = 5;
  final reviews = ['Great communication and a clear plan.'];
  final input = TextEditingController();
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Ratings & reviews')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Center(
            child: Column(children: [
          Text('4.8', style: Theme.of(c).textTheme.displayMedium),
          const Text('★★★★★'),
          const Text('Based on 24 reviews')
        ])),
        ...const [0.8, 0.15, 0.05].map((v) => Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: LinearProgressIndicator(value: v))),
        Text('Write a review', style: Theme.of(c).textTheme.titleLarge),
        Row(
            children: List.generate(
                5,
                (i) => IconButton(
                    onPressed: () => setState(() => star = i + 1),
                    icon: Icon(i < star ? Icons.star : Icons.star_border,
                        color: Colors.amber)))),
        TextField(
            controller: input,
            maxLines: 3,
            decoration: const InputDecoration(
                labelText: 'Review text', border: OutlineInputBorder())),
        AppPrimaryButton(
            label: 'Submit review',
            onPressed: () {
              if (input.text.isNotEmpty)
                setState(() {
                  reviews.add(input.text);
                  input.clear();
                });
            }),
        ...reviews.map((x) => ListTile(
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Ali Raza · 12 Sep 2026'),
            subtitle: Text(x)))
      ]));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.business});
  final bool business;
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: const [
        ListTile(title: Text('Profile')),
        ListTile(title: Text('Language'), subtitle: Text('English · Urdu')),
        ListTile(title: Text('Notifications')),
        ListTile(title: Text('Theme')),
        ListTile(title: Text('Privacy')),
        ListTile(title: Text('Terms')),
        ListTile(title: Text('About')),
        ListTile(title: Text('Logout'))
      ]));
}
