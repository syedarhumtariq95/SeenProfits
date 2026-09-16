import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/notification_model.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import 'notification_status_chip.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.notifications});
  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Center(child: Text(context.l10n.noNotificationsFound));
    }
    final dateFormat =
        DateFormat.yMMMd(Localizations.localeOf(context).toString()).add_jm();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        for (final notification in notifications)
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
                child: Icon(_iconFor(notification.targetAudience))),
            title: Text(notification.title),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                  '${notification.message}\n${_audienceLabel(context, notification.targetAudience)} · ${dateFormat.format(notification.sentAt)}'),
            ),
            isThreeLine: true,
            trailing: SizedBox(
              width: 118,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    NotificationStatusChip(status: notification.status),
                    Text(
                        '${NumberFormat.decimalPattern().format(notification.totalRecipients)} ${context.l10n.recipients}',
                        style: Theme.of(context).textTheme.bodySmall),
                    if (notification.status == NotificationStatus.failed)
                      TextButton(
                          onPressed: () => context
                              .read<NotificationBloc>()
                              .add(ResendNotification(notification.id)),
                          child: Text(context.l10n.resend)),
                  ]),
            ),
          ),
      ]),
    );
  }

  IconData _iconFor(NotificationAudience audience) => switch (audience) {
        NotificationAudience.allUsers => Icons.groups_outlined,
        NotificationAudience.investors => Icons.account_balance_outlined,
        NotificationAudience.businessOwners => Icons.storefront_outlined,
      };

  String _audienceLabel(BuildContext context, NotificationAudience audience) =>
      switch (audience) {
        NotificationAudience.allUsers => context.l10n.allUsers,
        NotificationAudience.investors => context.l10n.investors,
        NotificationAudience.businessOwners => context.l10n.businessOwners,
      };
}
