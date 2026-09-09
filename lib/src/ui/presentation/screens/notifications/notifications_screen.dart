import 'package:flutter/material.dart';

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
    'New message'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Notifications'), actions: [
        TextButton(
            onPressed: () => setState(() => read.addAll([0, 1, 2, 3])),
            child: const Text('Mark all read'))
      ]),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index) => ListTile(
              tileColor: read.contains(index)
                  ? null
                  : Theme.of(context).colorScheme.primaryContainer,
              title: Text(data[index]),
              subtitle: const Text('Today · Tap to mark as read'),
              leading: const Icon(Icons.notifications),
              trailing: read.contains(index)
                  ? null
                  : const Icon(Icons.circle, size: 10),
              onTap: () => setState(() => read.add(index)))));
}
