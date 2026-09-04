import 'package:flutter/material.dart';
import 'package:seen_profits/l10n/app_localizations.dart';
import 'package:seen_profits/src/ui/presentation/screens/home/home_localizations.dart';

import '../../../generics/widgets/buttons/app_primary_button.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusinessScreen> {
  int step = 0;

  final form = GlobalKey<FormState>();

  final fields = const [
    ['Business name', 'ABC General Store'],
    ['Category', 'Retail'],
    ['Description', 'A trusted local business'],
    ['City', 'Lahore'],
    ['Start date', '01/01/2022'],
    ['Monthly revenue', 'Rs. 180,000'],
    ['Monthly expenses', 'Rs. 80,000'],
    ['Bank account', '**** **** 1234'],
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final currentFields = fields.skip(step * 3).take(3).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l.addBusiness)),
      body: Form(
        key: form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            LinearProgressIndicator(value: (step + 1) / 3),
            const SizedBox(height: 20),

            Text(
              '${l.step} ${step + 1} ${l.ofLabel} 3',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            ...currentFields.map(
              (field) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextFormField(
                  initialValue: field[1],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l.requiredField;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: field[0],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),

            if (step == 2) ...[
              Text(
                l.privateDocuments,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              ...[
                'CNIC front / back',
                'Shop ownership or rent proof',
                'Bank statement',
                'Sales records and utility bill',
                'Business photos',
              ].map(
                (document) => ListTile(
                  leading: const Icon(Icons.upload_file_outlined),
                  title: Text(document),
                  trailing: const Icon(Icons.check_circle_outline),
                ),
              ),
            ],

            const SizedBox(height: 20),

            AppPrimaryButton(
              label: step < 2 ? l.next : l.submitForVerification,
              onPressed: () {
                if (!form.currentState!.validate()) {
                  return;
                }

                if (step < 2) {
                  setState(() {
                    step++;
                  });
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(l.submittedForReview)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final statuses = [
      l.pending,
      l.approved,
      l.rejected,
      l.changesRequired,
      l.suspended,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.verificationStatus)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l.verificationWorkflow,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          ...statuses.map(
            (status) => Card(
              child: ListTile(
                leading: Icon(
                  Icons.verified_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(status),
                subtitle: Text(l.statusExplanation),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeekInvestmentScreen extends StatefulWidget {
  const SeekInvestmentScreen({super.key});

  @override
  State<SeekInvestmentScreen> createState() => _SeekInvestmentScreenState();
}

class _SeekInvestmentScreenState extends State<SeekInvestmentScreen> {
  String? selectedPurpose;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final purposes = [l.inventoryExpansion, l.businessExpansion, l.equipment];

    return Scaffold(
      appBar: AppBar(title: Text(l.seekInvestment)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            initialValue: l.rs100000,
            decoration: InputDecoration(
              labelText: l.requiredAmount,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 14),

          DropdownButtonFormField<String>(
            initialValue: selectedPurpose,
            items: purposes
                .map(
                  (purpose) => DropdownMenuItem<String>(
                    value: purpose,
                    child: Text(purpose),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedPurpose = value;
              });
            },
            decoration: InputDecoration(
              labelText: l.investmentPurpose,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 14),

          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: l.proposedTerms,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            l.discoveryDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 16),

          AppPrimaryButton(
            label: l.submitOpportunity,
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text(l.opportunitySubmitted),
                    content: Text(l.staticMockStatus),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Text(l.close),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final items = [
      l.verificationApprovedNotification,
      l.investmentInterestNotification,
      l.newMessageNotification,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.notifications)),
      body: items.isEmpty
          ? Center(child: Text(l.noNotifications))
          : ListView(
              children: items
                  .map(
                    (item) => ListTile(
                      leading: const Icon(Icons.notifications_none),
                      title: Text(item),
                      subtitle: Text(l.today),
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l.favorites)),
      body: Center(child: Text(l.noFavorites)),
    );
  }
}

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l.profileSettings)),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Seen Profits User'),
            subtitle: Text('user@example.com'),
          ),

          ListTile(
            title: Text(l.editProfile),
            leading: const Icon(Icons.edit_outlined),
          ),

          ListTile(
            title: Text(l.language),
            leading: const Icon(Icons.language),
          ),

          ListTile(
            title: Text(l.notificationSettings),
            leading: const Icon(Icons.notifications_outlined),
          ),

          ListTile(
            title: Text(l.privacySecurity),
            leading: const Icon(Icons.lock_outline),
          ),

          ListTile(title: Text(l.logout), leading: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
