import 'package:flutter/material.dart';
import '../../../../../domain/models/business_listing_status.dart';
import '../../../../generics/widgets/buttons/app_primary_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, this.status});
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
      BusinessListingStatus.pending ||
      BusinessListingStatus.noBusiness ||
      null =>
        'Pending'
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = s == 'Approved'
        ? Colors.green
        : s == 'Rejected'
            ? Colors.red
            : Colors.orange;
    return Scaffold(
        appBar: AppBar(title: const Text('Verification')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          DropdownButtonFormField<String>(
              initialValue: s,
              items: const [
                'Pending',
                'Approved',
                'Rejected',
                'Changes Required',
                'Suspended'
              ]
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => s = value);
              },
              decoration: const InputDecoration(
                  labelText: 'Demo status', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          Card(
              color: color.withOpacity(.12),
              child: ListTile(
                  leading: Icon(Icons.verified, color: color, size: 42),
                  title: Text(s),
                  subtitle: Text(s == 'Approved'
                      ? 'Your business is visible to investors.'
                      : 'Review message: upload clearer ownership evidence if requested.'))),
          const SizedBox(height: 16),
          const Text('Verification progress'),
          const SizedBox(height: 8),
          LinearProgressIndicator(
              value: s == 'Approved'
                  ? 1.0
                  : s == 'Pending'
                      ? .7
                      : .45),
          const SizedBox(height: 12),
          ...[
            'Business ownership',
            'Business age evidence',
            'Identity document',
            'Financial records'
          ].map((item) => Card(
              child: ListTile(
                  title: Text(item),
                  subtitle: Text(s == 'Changes Required'
                      ? 'Changes required'
                      : 'Document submitted'),
                  trailing: Icon(Icons.check_circle, color: color)))),
          if (s != 'Approved')
            AppPrimaryButton(
                label: 'Update / Resubmit',
                onPressed: () => setState(() => s = 'Pending'))
        ]));
  }
}
