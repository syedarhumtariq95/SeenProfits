import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/notification_model.dart';

class NotificationStatusChip extends StatelessWidget {
  const NotificationStatusChip({super.key, required this.status});
  final NotificationStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      NotificationStatus.sent => (context.l10n.notificationSent, Colors.green),
      NotificationStatus.pending => (
          context.l10n.notificationPending,
          Colors.orange
        ),
      NotificationStatus.failed => (
          context.l10n.notificationFailed,
          Colors.redAccent
        ),
    };
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(color: color, fontSize: 12),
      side: BorderSide(color: color.withValues(alpha: .35)),
      backgroundColor: color.withValues(alpha: .10),
      visualDensity: VisualDensity.compact,
    );
  }
}
