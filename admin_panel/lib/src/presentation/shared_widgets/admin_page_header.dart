import 'package:flutter/material.dart';

class AdminPageHeader extends StatelessWidget {
  const AdminPageHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineSmall);
  }
}
