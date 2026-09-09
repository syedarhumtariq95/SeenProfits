import 'package:flutter/material.dart';
import '../../../../../configs/router/routes.dart';

class BusinessChatListScreen extends StatelessWidget {
  const BusinessChatListScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView(children: [
        ListTile(
            onTap: () =>
                Navigator.pushNamed(context, CustomRouter.chatRouteName),
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Ayesha Khan'),
            subtitle: const Text('Could we discuss the inventory plan?'),
            trailing: const Chip(label: Text('2')))
      ]));
}
