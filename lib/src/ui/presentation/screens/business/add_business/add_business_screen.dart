import 'package:flutter/material.dart';
import '../../../../../configs/router/routes.dart';
import '../../../../generics/widgets/buttons/app_primary_button.dart';
import '../../home/performance_chart.dart';

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
    'Verification'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
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
                            (index) => Expanded(
                                    child: Column(children: [
                                  CircleAvatar(
                                      backgroundColor: index <= step
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : null,
                                      child: Text('${index + 1}')),
                                  Text(names[index],
                                      textAlign: TextAlign.center)
                                ])))),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(value: (step + 1) / 3),
                    const SizedBox(height: 18),
                    Text(names[step],
                        style: Theme.of(context).textTheme.headlineSmall),
                    ..._fields(),
                    Row(children: [
                      if (step > 0)
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () => setState(() => step--),
                                child: const Text('Back'))),
                      if (step > 0) const SizedBox(width: 10),
                      Expanded(
                          child: AppPrimaryButton(
                              label: step == 2 ? 'Submit' : 'Continue',
                              onPressed: () {
                                if (form.currentState!.validate())
                                  setState(
                                      () => step == 2 ? done = true : step++);
                              }))
                    ]),
                  ],
                ),
              ),
      );
  List<Widget> _fields() {
    final fields = step == 0
        ? [
            'Business title',
            'Business category',
            'Business description',
            'Business start date',
            'Business age',
            'Business location'
          ]
        : step == 1
            ? [
                'Last month revenue / shop bill',
                'Monthly revenue',
                'Monthly expenses',
                'Monthly profit',
                'Required investment amount',
                'Investment purpose'
              ]
            : ['Business ownership information', 'Business age evidence'];
    return [
      ...fields.map((field) => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: TextFormField(
              maxLines:
                  field.contains('description') || field.contains('purpose')
                      ? 3
                      : 1,
              validator: (value) => value!.isEmpty ? 'Required' : null,
              decoration: InputDecoration(
                  labelText: field, border: const OutlineInputBorder())))),
      if (step == 0)
        const Card(
            child: ListTile(
                leading: Icon(Icons.map),
                title: Text('Map location selected'),
                subtitle: Text('Main Market, Lahore'))),
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
                    'Review your details and documents before submitting. Private documents are never visible to investors.')))
      ]
    ];
  }

  Widget _upload(String title) => Card(
      child: ListTile(
          leading: const Icon(Icons.upload_file),
          title: Text(title),
          subtitle: const Text('Tap to upload document'),
          trailing: const Icon(Icons.chevron_right)));
  Widget _done() => Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.check_circle, size: 70, color: Colors.green),
        const Text('Business submitted for verification'),
        const Text('Status: Pending review'),
        AppPrimaryButton(
            label: 'View verification',
            onPressed: () => Navigator.pushReplacementNamed(
                context, CustomRouter.verificationRouteName))
      ]));
}
