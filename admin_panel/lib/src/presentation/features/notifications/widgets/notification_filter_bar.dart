import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../../../../domain/models/notification_model.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';

class NotificationFilterBar extends StatelessWidget {
  const NotificationFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((NotificationBloc bloc) => bloc.state);
    final search = TextField(
      onChanged: (value) => context.read<NotificationBloc>().add(
            FilterNotifications(
                query: value, audience: state.audience, status: state.status),
          ),
      decoration: InputDecoration(
          hintText: context.l10n.searchNotifications,
          prefixIcon: const Icon(Icons.search)),
    );
    final audience = DropdownButtonFormField<NotificationAudience?>(
      initialValue: state.audience,
      decoration: InputDecoration(labelText: context.l10n.recipientAudience),
      items: [
        DropdownMenuItem(value: null, child: Text(context.l10n.allRecipients)),
        DropdownMenuItem(
            value: NotificationAudience.allUsers,
            child: Text(context.l10n.allUsers)),
        DropdownMenuItem(
            value: NotificationAudience.investors,
            child: Text(context.l10n.investors)),
        DropdownMenuItem(
            value: NotificationAudience.businessOwners,
            child: Text(context.l10n.businessOwners)),
      ],
      onChanged: (value) => context.read<NotificationBloc>().add(
            FilterNotifications(
                query: state.query, audience: value, status: state.status),
          ),
    );
    final status = DropdownButtonFormField<NotificationStatus?>(
      initialValue: state.status,
      decoration: InputDecoration(labelText: context.l10n.notificationStatus),
      items: [
        DropdownMenuItem(value: null, child: Text(context.l10n.allStatuses)),
        DropdownMenuItem(
            value: NotificationStatus.sent,
            child: Text(context.l10n.notificationSent)),
        DropdownMenuItem(
            value: NotificationStatus.failed,
            child: Text(context.l10n.notificationFailed)),
      ],
      onChanged: (value) => context.read<NotificationBloc>().add(
            FilterNotifications(
                query: state.query, audience: state.audience, status: value),
          ),
    );
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth >=
              AdminBreakpoints.tablet
          ? Row(children: [
              Expanded(child: search),
              const SizedBox(width: 12),
              SizedBox(width: 210, child: audience),
              const SizedBox(width: 12),
              SizedBox(width: 170, child: status)
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              search,
              const SizedBox(height: 12),
              audience,
              const SizedBox(height: 12),
              status
            ]),
    );
  }
}
