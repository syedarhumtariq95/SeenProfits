import 'package:flutter/material.dart';
import '../../../../../configs/router/routes.dart';

class BusinessRequestsScreen extends StatefulWidget {
  const BusinessRequestsScreen({super.key});
  @override
  State<BusinessRequestsScreen> createState() => _Requests();
}

class _Requests extends State<BusinessRequestsScreen> {
  final rows = [
    ['Ayesha Khan', 'Rs. 100,000', 'Pending'],
    ['Bilal Ahmed', 'Rs. 250,000', 'Negotiating'],
    ['Sara Malik', 'Rs. 50,000', 'Completed']
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Investor requests')),
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: rows
              .map((row) => Card(
                  child: ListTile(
                      onTap: () => _actions(row),
                      leading: CircleAvatar(child: Text(row[0][0])),
                      title: Text(row[0]),
                      subtitle:
                          Text('${row[1]} · 12 Sep · Interested in inventory'),
                      trailing: Chip(label: Text(row[2])))))
              .toList()));
  void _actions(List<String> row) => showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(children: [
            Text(row[0], style: Theme.of(sheetContext).textTheme.titleLarge),
            const Text('View request details and respond locally.'),
            Wrap(
                spacing: 8,
                children: ['Accept', 'Reject', 'Negotiate', 'Connect / Chat']
                    .map((action) => OutlinedButton(
                        onPressed: () {
                          setState(() => row[2] = action == 'Accept'
                              ? 'Accepted'
                              : action == 'Reject'
                                  ? 'Rejected'
                                  : action == 'Negotiate'
                                      ? 'Negotiating'
                                      : row[2]);
                          Navigator.pop(sheetContext);
                          if (action == 'Connect / Chat')
                            Navigator.pushNamed(
                                context, CustomRouter.chatRouteName);
                        },
                        child: Text(action)))
                    .toList())
          ])));
}
