import 'package:flutter/material.dart';

import '../../../configs/localization/localization_extensions.dart';
import '../../../configs/router/admin_navigation.dart';
import '../../shared_widgets/admin_page_header.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.routeName});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final item = adminNavigationItems
        .where((item) => item.route == routeName)
        .firstOrNull;
    final title = item?.label(context) ?? l10n.adminPortal;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminPageHeader(title: title),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.comingSoon,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(l10n.comingSoonDescription),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
