import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../../../../domain/models/user_model.dart';

Future<void> showUserDetailModal(
    {required BuildContext context, required UserModel user}) {
  final child = UserDetailContent(user: user);
  if (MediaQuery.sizeOf(context).width >= AdminBreakpoints.tablet) {
    return showDialog<void>(
        context: context,
        builder: (_) => Dialog(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: child,
            )));
  }
  return showModalBottomSheet<void>(
      context: context, isScrollControlled: true, builder: (_) => child);
}

class UserDetailContent extends StatelessWidget {
  const UserDetailContent({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) => SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
                child: Text(context.l10n.userDetails,
                    style: Theme.of(context).textTheme.headlineSmall)),
            IconButton(
                onPressed: () => Navigator.pop(context),
                tooltip: context.l10n.close,
                icon: const Icon(Icons.close))
          ]),
          const SizedBox(height: 20),
          CircleAvatar(radius: 30, child: Text(user.name.substring(0, 1))),
          const SizedBox(height: 16),
          _DetailRow(label: context.l10n.name, value: user.name),
          _DetailRow(label: context.l10n.email, value: user.email),
          _DetailRow(label: context.l10n.phone, value: user.phone),
          _DetailRow(
              label: context.l10n.userRole,
              value: _roleLabel(context, user.role)),
          _DetailRow(
              label: context.l10n.userStatus,
              value: _statusLabel(context, user.status)),
        ]),
      ));
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(children: [
        SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge)),
        Expanded(child: Text(value)),
      ]));
}

String _roleLabel(BuildContext context, UserRole role) =>
    role == UserRole.investor
        ? context.l10n.investor
        : context.l10n.businessOwner;
String _statusLabel(BuildContext context, UserStatus status) =>
    status == UserStatus.active ? context.l10n.active : context.l10n.suspended;
