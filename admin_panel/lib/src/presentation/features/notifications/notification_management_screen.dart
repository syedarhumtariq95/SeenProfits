import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';
import 'widgets/broadcast_notification_dialog.dart';
import 'widgets/notification_filter_bar.dart';
import 'widgets/notification_list.dart';
import 'widgets/notification_shimmer.dart';
import 'widgets/notification_stats_overview.dart';

class NotificationManagementScreen extends StatelessWidget {
  const NotificationManagementScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<NotificationBloc>()
          ..add(const FetchNotifications()),
        child: const _NotificationManagementView(),
      );
}

class _NotificationManagementView extends StatelessWidget {
  const _NotificationManagementView();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state.actionStatus == NotificationActionStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(context.l10n.notificationActionFailed)));
            }
          },
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              final loading =
                  state.loadStatus == NotificationLoadStatus.loading ||
                      state.loadStatus == NotificationLoadStatus.initial;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                          child: AdminPageHeader(
                              title: context.l10n.notifications)),
                      FilledButton.icon(
                          onPressed: loading
                              ? null
                              : () => showBroadcastNotificationDialog(context),
                          icon: const Icon(Icons.add_alert_outlined),
                          label: Text(context.l10n.broadcastNotification)),
                    ]),
                    const SizedBox(height: 24),
                    if (loading)
                      const NotificationShimmer()
                    else ...[
                      NotificationStatsOverview(state: state),
                      const SizedBox(height: 24),
                      const NotificationFilterBar(),
                      const SizedBox(height: 20),
                      NotificationList(
                          notifications: state.visibleNotifications),
                    ],
                    if (state.loadStatus == NotificationLoadStatus.failure)
                      Center(child: Text(context.l10n.notificationsLoadFailed)),
                  ]);
            },
          ),
        ),
      );
}
