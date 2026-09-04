import 'package:flutter/material.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import '../../../../configs/router/routes.dart';
import '../../../generics/widgets/branding/app_logo.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';


class BusinessHomeScreen extends StatelessWidget {
  const BusinessHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: const AppLogo(size: 42)),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(20), children: [
        Text(l10n.welcomeBusiness,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        _SummaryCard(title: l10n.businessProfile, children: [
          _InfoRow(l10n.businessName, l10n.abcGeneralStore),
          _InfoRow(l10n.category, l10n.retail),
          _InfoRow(l10n.businessAge, l10n.twoYears),
          _InfoRow(l10n.investmentRequired, l10n.rs100000),
          _InfoRow(l10n.verificationStatus, l10n.verified),
        ]),
        const SizedBox(height: 20),
        Text(l10n.quickActions,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Wrap(spacing: 10, runSpacing: 10, children: [
          for (final item in [
            l10n.myBusiness,
            l10n.seekInvestment,
            l10n.investmentRequests,
            l10n.investorsConnections,
            l10n.chat,
            l10n.notifications
          ])
            ActionChip(
                avatar: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: Text(item),
                onPressed: () {}),
        ]),
      ])),
    );
  }
}

class InvestorHomeScreen extends StatelessWidget {
  const InvestorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: const AppLogo(size: 42)),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(20), children: [
        Text(l10n.welcomeInvestor,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        TextField(
            decoration: InputDecoration(
                labelText: l10n.searchBusinesses,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16)))),
        const SizedBox(height: 14),
        Wrap(
            spacing: 8,
            children: [
              l10n.all,
              l10n.retail,
              l10n.foodRestaurant,
              l10n.services
            ]
                .map((e) => FilterChip(
                    label: Text(e),
                    selected: e == l10n.all,
                    onSelected: (_) {}))
                .toList()),
        const SizedBox(height: 22),
        Text(l10n.featuredBusinesses,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _BusinessCard(
            title: l10n.abcGeneralStore,
            category: l10n.retail,
            age: l10n.twoYears,
            location: l10n.lahore,
            amount: l10n.rs100000,
            description: l10n.generalStoreDescription,
            onDetails: () => Navigator.of(context)
                .pushNamed(CustomRouter.businessDetailsRouteName)),
        _BusinessCard(
            title: l10n.xyzRestaurant,
            category: l10n.foodRestaurant,
            age: l10n.threeYears,
            location: l10n.islamabad,
            amount: l10n.rs500000,
            description: l10n.restaurantDescription,
            onDetails: () => Navigator.of(context)
                .pushNamed(CustomRouter.businessDetailsRouteName)),
      ])),
    );
  }
}

class BusinessDetailsScreen extends StatelessWidget {
  const BusinessDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.businessDetails)),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const AppLogo(size: 64),
          const SizedBox(height: 18),
          Text(l10n.abcGeneralStore,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _SummaryCard(title: l10n.businessOverview, children: [
            _InfoRow(l10n.category, l10n.retail),
            _InfoRow(l10n.businessAge, l10n.twoYears),
            _InfoRow(l10n.location, l10n.lahore),
            _InfoRow(l10n.rating, l10n.ratingValue),
            _InfoRow(l10n.verificationStatus, l10n.verified),
            _InfoRow(l10n.investmentRequired, l10n.rs100000)
          ]),
          const SizedBox(height: 16),
          Text(l10n.generalStoreDescription),
          const SizedBox(height: 12),
          Text(l10n.investmentPurpose,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          Text(l10n.inventoryExpansion),
          const SizedBox(height: 16),
          Container(
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(l10n.performanceGraphPlaceholder)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: AppPrimaryButton(
                    label: l10n.invest,
                    onPressed: () => showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                                title: Text(l10n.investmentConfirmation),
                                content: Text(l10n.staticInvestmentMessage),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(l10n.close))
                                ])))),
            const SizedBox(width: 12),
            Expanded(
                child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(CustomRouter.chatRouteName),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: Text(l10n.connect)))
          ])
        ]));
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _messages = <String>[];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.chatWithBusiness)),
        body: Column(children: [
          Expanded(
              child: ListView(padding: const EdgeInsets.all(16), children: [
            _bubble(l10n.helloInvestor, false, '10:30 AM'),
            _bubble(l10n.thanksForYourInterest, true, '10:31 AM'),
            ..._messages.map((m) => _bubble(m, false, 'Now'))
          ])),
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: l10n.typeMessage,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14))))),
                IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add(_controller.text.trim());
                          _controller.clear();
                        });
                      }
                    })
              ]))
        ]));
  }

  Widget _bubble(String text, bool mine, String timestamp) => Align(
      alignment: mine
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: mine
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(text),
            const SizedBox(height: 3),
            Text(timestamp, style: Theme.of(context).textTheme.labelSmall)
          ])));
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            ...children
          ])));
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600))
      ]));
}

class _BusinessCard extends StatelessWidget {
  const _BusinessCard(
      {required this.title,
      required this.category,
      required this.age,
      required this.location,
      required this.amount,
      required this.description,
      required this.onDetails});
  final String title, category, age, location, amount, description;
  final VoidCallback onDetails;
  @override
  Widget build(BuildContext context) => Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700))),
              const Icon(Icons.verified_rounded, color: Colors.green)
            ]),
            Text('$category • $age • $location'),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: Text(amount,
                      style: const TextStyle(fontWeight: FontWeight.w700))),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_rounded)),
              TextButton(
                  onPressed: onDetails,
                  child: Text(AppLocalizations.of(context)!.viewDetails))
            ])
          ])));
}
