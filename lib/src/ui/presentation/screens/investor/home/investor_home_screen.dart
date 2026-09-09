import 'package:flutter/material.dart';

import '../../../../../configs/router/routes.dart';
import '../../../../generics/widgets/buttons/app_primary_button.dart';
import '../business_detail/investor_business_detail_screen.dart';

/// Canonical routed investor home. This preserves the existing static UI and
/// local mock interactions while moving them into the investor feature.
class InvestorHomeScreen extends StatefulWidget {
  const InvestorHomeScreen({super.key});

  @override
  State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
}

class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
  final saved = <String>{};
  final category = <String>{};
  String location = 'Any';
  String sort = 'Recommended';
  final rows = [
    ['ABC General Store', 'Retail', 'Lahore', 'Rs. 100,000'],
    ['XYZ Restaurant', 'Food & Restaurant', 'Islamabad', 'Rs. 500,000'],
    ['Green Care Services', 'Services', 'Lahore', 'Rs. 75,000'],
  ];

  List<List<String>> get visible => rows
      .where((row) =>
          (category.isEmpty || category.contains(row[1])) &&
          (location == 'Any' || location == row[2]))
      .toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Investor Home'), actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, CustomRouter.notificationsRouteName),
              icon: const Icon(Icons.notifications_none)),
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, CustomRouter.profileSettingsRouteName),
              icon: const Icon(Icons.person_outline)),
        ]),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          TextField(
              decoration: InputDecoration(
                  labelText: 'Search verified businesses',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: _filter, icon: const Icon(Icons.tune)),
                  border: const OutlineInputBorder())),
          Row(children: [
            FilterChip(
                label: Text('Filters (${category.length})'),
                selected: category.isNotEmpty,
                onSelected: (_) => _filter()),
            const Spacer(),
            TextButton.icon(
                onPressed: () => Navigator.pushNamed(
                    context, CustomRouter.favoritesRouteName),
                icon: const Icon(Icons.favorite_border),
                label: const Text('Favorites'))
          ]),
          Text('${visible.length} businesses',
              style: Theme.of(context).textTheme.titleMedium),
          ...visible.map(_card),
        ]),
      );

  Widget _card(List<String> row) => Card(
      child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const CircleAvatar(child: Icon(Icons.store)),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(row[0],
                      style: Theme.of(context).textTheme.titleMedium)),
              IconButton(
                  onPressed: () => setState(() => saved.contains(row[0])
                      ? saved.remove(row[0])
                      : saved.add(row[0])),
                  icon: Icon(
                      saved.contains(row[0])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.pink))
            ]),
            Text('${row[1]} · Verified · ${row[2]} · 2 years · ★ 4.8'),
            Text('Investment required: ${row[3]}'),
            Row(children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(
                          context, CustomRouter.businessDetailsRouteName),
                      child: const Text('View details'))),
              const SizedBox(width: 8),
              Expanded(
                  child: FilledButton(
                      onPressed: () => _interest(context),
                      child: const Text('Invest')))
            ]),
          ])));

  void _interest(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const InterestSheet());

  void _filter() => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
          builder: (sheetContext, setModalState) => DraggableScrollableSheet(
              expand: false,
              initialChildSize: .8,
              builder: (_, scroll) => ListView(
                      controller: scroll,
                      padding: const EdgeInsets.all(20),
                      children: [
                        Row(children: [
                          Text('Filters',
                              style: Theme.of(sheetContext)
                                  .textTheme
                                  .headlineSmall),
                          const Spacer(),
                          TextButton(
                              onPressed: () => setModalState(() {
                                    category.clear();
                                    location = 'Any';
                                    sort = 'Recommended';
                                  }),
                              child: const Text('Clear all'))
                        ]),
                        const Text('CATEGORY — select multiple'),
                        Wrap(
                            spacing: 6,
                            children: [
                              'Retail',
                              'Food & Restaurant',
                              'Services',
                              'Manufacturing'
                            ]
                                .map((item) => FilterChip(
                                    label: Text(item),
                                    selected: category.contains(item),
                                    onSelected: (selected) => setModalState(
                                        () => selected
                                            ? category.add(item)
                                            : category.remove(item))))
                                .toList()),
                        _chips(
                            'Location',
                            ['Any', 'Lahore', 'Islamabad'],
                            location,
                            (value) => setModalState(() => location = value)),
                        _chips(
                            'Investment amount',
                            [
                              'Any amount',
                              'Under Rs. 100,000',
                              'Rs. 100,000–500,000',
                              'Over Rs. 500,000'
                            ],
                            'Any amount',
                            (_) {}),
                        _chips(
                            'Business age',
                            [
                              'Any age',
                              'Under 1 year',
                              '1–3 years',
                              '3+ years'
                            ],
                            'Any age',
                            (_) {}),
                        _chips('Minimum rating', ['Any rating', '4.0+', '4.5+'],
                            'Any rating', (_) {}),
                        _chips(
                            'Sorting',
                            [
                              'Recommended',
                              'Newest',
                              'Investment amount: Low to High',
                              'Investment amount: High to Low',
                              'Rating: High to Low',
                              'Business age'
                            ],
                            sort,
                            (value) => setModalState(() => sort = value)),
                        AppPrimaryButton(
                            label: 'Apply filters (${category.length})',
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(sheetContext);
                            }),
                      ]))));

  Widget _chips(String title, List<String> items, String selected,
          ValueChanged<String> onTap) =>
      Padding(
          padding: const EdgeInsets.only(top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title),
            Wrap(
                spacing: 6,
                children: items
                    .map((item) => ChoiceChip(
                        label: Text(item),
                        selected: item == selected,
                        onSelected: (_) => onTap(item)))
                    .toList())
          ]));
}
