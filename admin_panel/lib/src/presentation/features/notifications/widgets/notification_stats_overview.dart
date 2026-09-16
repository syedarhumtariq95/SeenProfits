import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../bloc/notification_state.dart';

class NotificationStatsOverview extends StatelessWidget {
  const NotificationStatsOverview({super.key, required this.state});
  final NotificationState state;

  @override
  Widget build(BuildContext context) {
    final number =
        NumberFormat.decimalPattern(Localizations.localeOf(context).toString());
    final items = [
      (
        context.l10n.totalNotifications,
        number.format(state.notifications.length),
        Icons.notifications_outlined
      ),
      (
        context.l10n.sentNotifications,
        number.format(state.sentCount),
        Icons.done_all_outlined
      ),
      (
        context.l10n.totalRecipients,
        number.format(state.totalRecipients),
        Icons.people_outline
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        crossAxisCount: constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= AdminBreakpoints.tablet
                ? 2
                : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3.3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final item in items)
            _StatCard(label: item.$1, value: item.$2, icon: item.$3)
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(
      {required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ]),
          ]),
        ),
      );
}
