import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/notification_model.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';

Future<void> showBroadcastNotificationDialog(BuildContext context) =>
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
          value: context.read<NotificationBloc>(),
          child: const BroadcastNotificationDialog()),
    );

class BroadcastNotificationDialog extends StatefulWidget {
  const BroadcastNotificationDialog({super.key});

  @override
  State<BroadcastNotificationDialog> createState() =>
      _BroadcastNotificationDialogState();
}

class _BroadcastNotificationDialogState
    extends State<BroadcastNotificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  NotificationAudience _audience = NotificationAudience.allUsers;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(context.l10n.broadcastNotification),
        content: SizedBox(
          width: 480,
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: context.l10n.notificationTitle),
                  validator: _required),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: context.l10n.notificationMessage),
                  validator: _required),
              const SizedBox(height: 12),
              DropdownButtonFormField<NotificationAudience>(
                initialValue: _audience,
                decoration:
                    InputDecoration(labelText: context.l10n.recipientAudience),
                items: [
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
                onChanged: (value) =>
                    setState(() => _audience = value ?? _audience),
              ),
            ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.cancel)),
          FilledButton(
              onPressed: _submit, child: Text(context.l10n.sendNotification)),
        ],
      );

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? context.l10n.requiredField : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<NotificationBloc>().add(SendNotification(
        title: _titleController.text.trim(),
        message: _messageController.text.trim(),
        targetAudience: _audience));
    Navigator.pop(context);
  }
}
