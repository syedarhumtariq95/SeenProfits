import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/user_model.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import 'user_action_dialogs.dart';
import 'user_detail_modal.dart';
import 'user_shimmer.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state.loadStatus == UserLoadStatus.initial ||
            state.loadStatus == UserLoadStatus.loading) {
          return const UserShimmer();
        }
        if (state.loadStatus == UserLoadStatus.failure) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: OutlinedButton.icon(
                        onPressed: () =>
                            context.read<UserBloc>().add(const FetchUsers()),
                        icon: const Icon(Icons.refresh),
                        label: Text(context.l10n.retry)),
                  )));
        }
        if (state.users.isEmpty) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(context.l10n.noUsersFound)));
        }
        return Card(
            clipBehavior: Clip.antiAlias,
            child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: constraints.maxWidth < 760
                                  ? 760
                                  : constraints.maxWidth),
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text(context.l10n.name)),
                              DataColumn(label: Text(context.l10n.email)),
                              DataColumn(label: Text(context.l10n.userRole)),
                              DataColumn(label: Text(context.l10n.userStatus)),
                              DataColumn(label: Text(context.l10n.actions))
                            ],
                            rows: state.users
                                .map((user) => _row(context, user))
                                .toList(),
                          )),
                    )));
      });

  DataRow _row(BuildContext context, UserModel user) => DataRow(cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(Text(_roleLabel(context, user.role))),
        DataCell(_StatusChip(status: user.status)),
        DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              tooltip: context.l10n.viewUser,
              onPressed: () =>
                  showUserDetailModal(context: context, user: user),
              icon: const Icon(Icons.visibility_outlined)),
          IconButton(
              tooltip: user.status == UserStatus.active
                  ? context.l10n.suspend
                  : context.l10n.activate,
              onPressed: () async {
                if (await confirmUserStatusChange(context, user) &&
                    context.mounted) {
                  context.read<UserBloc>().add(ToggleUserStatus(user));
                }
              },
              icon: Icon(user.status == UserStatus.active
                  ? Icons.block_outlined
                  : Icons.check_circle_outline)),
        ])),
      ]);
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final UserStatus status;
  @override
  Widget build(BuildContext context) {
    final color = status == UserStatus.active ? Colors.green : Colors.red;
    return Chip(
        label: Text(_statusLabel(context, status)),
        labelStyle: TextStyle(color: color),
        side: BorderSide(color: color.withValues(alpha: .5)),
        backgroundColor: color.withValues(alpha: .12),
        visualDensity: VisualDensity.compact);
  }
}

String _roleLabel(BuildContext context, UserRole role) =>
    role == UserRole.investor
        ? context.l10n.investor
        : context.l10n.businessOwner;
String _statusLabel(BuildContext context, UserStatus status) =>
    status == UserStatus.active ? context.l10n.active : context.l10n.suspended;
