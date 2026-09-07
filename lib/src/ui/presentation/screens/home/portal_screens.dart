import 'package:flutter/material.dart';
import '../../../../configs/router/routes.dart';
import '../../../../domain/models/business_listing_status.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';
import 'home_screens.dart';
import 'performance_chart.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});
  @override
  State<AddBusinessScreen> createState() => _AddBusiness();
}

class _AddBusiness extends State<AddBusinessScreen> {
  int step = 0;
  bool done = false;
  final form = GlobalKey<FormState>();
  final names = [
    'Business information',
    'Financial information',
    'Verification',
  ];
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Add business')),
    body: done
        ? _done()
        : Form(
            key: form,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: List.generate(
                    3,
                    (i) => Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: i <= step
                                ? Theme.of(c).colorScheme.primary
                                : null,
                            child: Text('${i + 1}'),
                          ),
                          Text(names[i], textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: (step + 1) / 3),
                const SizedBox(height: 18),
                Text(names[step], style: Theme.of(c).textTheme.headlineSmall),
                ..._fields(),
                Row(
                  children: [
                    if (step > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => step--),
                          child: const Text('Back'),
                        ),
                      ),
                    if (step > 0) const SizedBox(width: 10),
                    Expanded(
                      child: AppPrimaryButton(
                        label: step == 2 ? 'Submit' : 'Continue',
                        onPressed: () {
                          if (form.currentState!.validate())
                            setState(() => step == 2 ? done = true : step++);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
  );
  List<Widget> _fields() {
    final a = step == 0
        ? [
            'Business title',
            'Business category',
            'Business description',
            'Business start date',
            'Business age',
            'Business location',
          ]
        : step == 1
        ? [
            'Last month revenue / shop bill',
            'Monthly revenue',
            'Monthly expenses',
            'Monthly profit',
            'Required investment amount',
            'Investment purpose',
          ]
        : ['Business ownership information', 'Business age evidence'];
    return [
      ...a.map(
        (x) => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: TextFormField(
            maxLines: x.contains('description') || x.contains('purpose')
                ? 3
                : 1,
            validator: (v) => v!.isEmpty ? 'Required' : null,
            decoration: InputDecoration(
              labelText: x,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
      if (step == 0)
        const Card(
          child: ListTile(
            leading: Icon(Icons.map),
            title: Text('Map location selected'),
            subtitle: Text('Main Market, Lahore'),
          ),
        ),
      if (step == 0) _upload('Business images'),
      if (step == 1) const PerformanceChart(data: demoPerformance),
      if (step == 2) ...[
        _upload('CNIC / identity document'),
        _upload('Ownership or rental proof'),
        _upload('Financial records'),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Review your details and documents before submitting. Private documents are never visible to investors.',
            ),
          ),
        ),
      ],
    ];
  }

  Widget _upload(String t) => Card(
    child: ListTile(
      leading: const Icon(Icons.upload_file),
      title: Text(t),
      subtitle: const Text('Tap to upload document'),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
  Widget _done() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, size: 70, color: Colors.green),
        const Text('Business submitted for verification'),
        const Text('Status: Pending review'),
        AppPrimaryButton(
          label: 'View verification',
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            CustomRouter.verificationRouteName,
          ),
        ),
      ],
    ),
  );
}

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    this.status,
  });

  final BusinessListingStatus? status;

  @override
  State<VerificationScreen> createState() => _Verification();
}

class _Verification extends State<VerificationScreen> {
  late String s;

  @override
  void initState() {
    super.initState();

    s = switch (widget.status) {
      BusinessListingStatus.approved => 'Approved',
      BusinessListingStatus.rejected => 'Rejected',
      BusinessListingStatus.changesRequired => 'Changes Required',
      BusinessListingStatus.suspended => 'Suspended',
      BusinessListingStatus.pending => 'Pending',
      BusinessListingStatus.noBusiness => 'Pending',
      null => 'Pending',
    };
  }
  @override
  Widget build(BuildContext c) {
    final color = s == 'Approved'
        ? Colors.green
        : s == 'Rejected'
        ? Colors.red
        : Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            initialValue: s,
            items: const [
              'Pending',
              'Approved',
              'Rejected',
              'Changes Required',
              'Suspended',
            ]
                .map(
                  (x) => DropdownMenuItem(
                value: x,
                child: Text(x),
              ),
            )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => s = v);
              }
            },
            decoration: const InputDecoration(
              labelText: 'Demo status',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            color: color.withOpacity(.12),
            child: ListTile(
              leading: Icon(
                Icons.verified,
                color: color,
                size: 42,
              ),
              title: Text(s),
              subtitle: Text(
                s == 'Approved'
                    ? 'Your business is visible to investors.'
                    : 'Review message: upload clearer ownership evidence if requested.',
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text('Verification progress'),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: s == 'Approved'
                ? 1.0
                : s == 'Pending'
                ? 0.7
                : 0.45,
          ),

          const SizedBox(height: 12),

          ...[
            'Business ownership',
            'Business age evidence',
            'Identity document',
            'Financial records',
          ].map(
                (x) => Card(
              child: ListTile(
                title: Text(x),
                subtitle: Text(
                  s == 'Changes Required'
                      ? 'Changes required'
                      : 'Document submitted',
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: color,
                ),
              ),
            ),
          ),

          if (s != 'Approved')
            AppPrimaryButton(
              label: 'Update / Resubmit',
              onPressed: () {
                setState(() => s = 'Pending');
              },
            ),
        ],
      ),
    );
  }
}

class SeekInvestmentScreen extends StatefulWidget {
  const SeekInvestmentScreen({super.key});
  @override
  State<SeekInvestmentScreen> createState() => _Seek();
}

class _Seek extends State<SeekInvestmentScreen> {
  bool done = false;
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Seek investment')),
    body: done
        ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                Text('Opportunity submitted — pending review'),
              ],
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ...[
                'Required investment amount',
                'Investment purpose',
                'Description',
              ].map(
                (x) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    maxLines: x == 'Description' ? 3 : 1,
                    decoration: InputDecoration(
                      labelText: x,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const PerformanceChart(data: demoPerformance),
              const Card(
                child: ListTile(
                  title: Text('Performance summary'),
                  subtitle: Text(
                    'Revenue Rs. 240,000 · Expenses Rs. 98,000 · Profit Rs. 142,000',
                  ),
                ),
              ),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Disclaimer: Seen Profits does not guarantee returns or participate in investment agreements.',
                  ),
                ),
              ),
              AppPrimaryButton(
                label: 'Review & submit',
                onPressed: () => setState(() => done = true),
              ),
            ],
          ),
  );
}

class BusinessRequestsScreen extends StatefulWidget {
  const BusinessRequestsScreen({super.key});
  @override
  State<BusinessRequestsScreen> createState() => _Requests();
}

class _Requests extends State<BusinessRequestsScreen> {
  final rows = [
    ['Ayesha Khan', 'Rs. 100,000', 'Pending'],
    ['Bilal Ahmed', 'Rs. 250,000', 'Negotiating'],
    ['Sara Malik', 'Rs. 50,000', 'Completed'],
  ];
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Investor requests')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: rows
          .map(
            (r) => Card(
              child: ListTile(
                onTap: () => _actions(r),
                leading: CircleAvatar(child: Text(r[0][0])),
                title: Text(r[0]),
                subtitle: Text('${r[1]} · 12 Sep · Interested in inventory'),
                trailing: Chip(label: Text(r[2])),
              ),
            ),
          )
          .toList(),
    ),
  );
  void _actions(List<String> r) => showModalBottomSheet(
    context: context,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        children: [
          Text(r[0], style: Theme.of(ctx).textTheme.titleLarge),
          const Text('View request details and respond locally.'),
          Wrap(
            spacing: 8,
            children: ['Accept', 'Reject', 'Negotiate', 'Connect / Chat']
                .map(
                  (x) => OutlinedButton(
                    onPressed: () {
                      setState(
                        () => r[2] = x == 'Accept'
                            ? 'Accepted'
                            : x == 'Reject'
                            ? 'Rejected'
                            : x == 'Negotiate'
                            ? 'Negotiating'
                            : r[2],
                      );
                      Navigator.pop(ctx);
                      if (x == 'Connect / Chat')
                        Navigator.pushNamed(
                          context,
                          CustomRouter.chatRouteName,
                        );
                    },
                    child: Text(x),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}

class BusinessChatListScreen extends StatelessWidget {
  const BusinessChatListScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Messages')),
    body: ListView(
      children: [
        ListTile(
          onTap: () => Navigator.pushNamed(c, CustomRouter.chatRouteName),
          leading: const CircleAvatar(child: Text('A')),
          title: const Text('Ayesha Khan'),
          subtitle: const Text('Could we discuss the inventory plan?'),
          trailing: const Chip(label: Text('2')),
        ),
      ],
    ),
  );
}

class BusinessConversationScreen extends StatelessWidget {
  const BusinessConversationScreen({super.key});
  @override
  Widget build(BuildContext c) => const ChatScreen();
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _Notifications();
}

class _Notifications extends State<NotificationsScreen> {
  final read = <int>{};
  final data = [
    'Business verification update',
    'New investor interest',
    'Investment request',
    'New message',
  ];
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: const Text('Notifications'),
      actions: [
        TextButton(
          onPressed: () => setState(() => read.addAll([0, 1, 2, 3])),
          child: const Text('Mark all read'),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) => ListTile(
        tileColor: read.contains(i)
            ? null
            : Theme.of(c).colorScheme.primaryContainer,
        title: Text(data[i]),
        subtitle: const Text('Today · Tap to mark as read'),
        leading: const Icon(Icons.notifications),
        trailing: read.contains(i) ? null : const Icon(Icons.circle, size: 10),
        onTap: () => setState(() => read.add(i)),
      ),
    ),
  );
}

class BusinessProfileSettingsScreen extends StatelessWidget {
  const BusinessProfileSettingsScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Business profile')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: CircleAvatar(radius: 40, child: Icon(Icons.store, size: 40)),
        ),
        Text(
          'ABC General Store',
          textAlign: TextAlign.center,
          style: Theme.of(c).textTheme.headlineSmall,
        ),
        const Chip(label: Text('Verified')),
        const Card(
          child: Column(
            children: [
              ListTile(title: Text('Retail'), subtitle: Text('Category')),
              ListTile(
                title: Text('Lahore · 4 years'),
                subtitle: Text('Location and business age'),
              ),
              ListTile(
                title: Text('Business images'),
                subtitle: Text('Storefront and interior'),
              ),
              ListTile(
                title: Text('Revenue Rs. 240,000 · Profit Rs. 142,000'),
                subtitle: Text('Performance summary'),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () =>
              Navigator.pushNamed(c, CustomRouter.addBusinessRouteName),
          child: const Text('Edit business'),
        ),
        OutlinedButton(onPressed: () {}, child: const Text('Edit profile')),
        const ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
      ],
    ),
  );
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _Favorites();
}

class _Favorites extends State<FavoritesScreen> {
  final names = ['ABC General Store', 'XYZ Restaurant'];
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Favorites')),
    body: names.isEmpty
        ? const Center(child: Text('No saved businesses yet'))
        : ListView(
            children: names
                .map(
                  (x) => ListTile(
                    title: Text(x),
                    subtitle: const Text('Verified · Lahore'),
                    trailing: IconButton(
                      onPressed: () => setState(() => names.remove(x)),
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                    ),
                  ),
                )
                .toList(),
          ),
  );
}
