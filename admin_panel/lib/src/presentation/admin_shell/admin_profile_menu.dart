import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/dependency_injection/dependency_injection.dart';
import '../../configs/localization/localization_extensions.dart';
import '../../configs/router/admin_routes.dart';
import '../../core/auth/admin_session.dart';
import '../../core/permissions/admin_permissions.dart';
import '../features/auth/bloc/admin_auth_cubit.dart';

class AdminProfileMenu extends StatelessWidget {
  const AdminProfileMenu({super.key, this.showDetails = true});

  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final session = AdminDependencyInjection.get<AdminSession>();
    final role = session.role ?? AdminRole.analyst;
    final l10n = context.l10n;
    return PopupMenuButton<_AdminProfileAction>(
      tooltip: l10n.profile,
      onSelected: (action) => _onSelected(context, action),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: _ProfileSummary(role: role, showDetails: true),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: _AdminProfileAction.settings,
          child: Text(l10n.profileSettings),
        ),
        PopupMenuItem(
          value: _AdminProfileAction.logout,
          child: Text(l10n.signOut),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: _ProfileSummary(role: role, showDetails: showDetails),
      ),
    );
  }

  Future<void> _onSelected(
      BuildContext context,
      _AdminProfileAction action,
      ) async {
    if (action == _AdminProfileAction.settings) {
      Navigator.of(context).pushNamed(AdminRouteNames.settings);
      return;
    }

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dialogContext.l10n.logoutConfirmationTitle),
        content: Text(dialogContext.l10n.logoutConfirmationMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(dialogContext.l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(dialogContext.l10n.signOut),
          ),
        ],
      ),
    );
    if (shouldLogout != true || !context.mounted) {
      return;
    }
    await context.read<AdminAuthCubit>().logout();
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AdminRouteNames.login,
            (route) => false,
      );
    }
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({required this.role, this.showDetails = false});

  final AdminRole role;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 18,
          child: Icon(Icons.admin_panel_settings_outlined, size: 20),
        ),
        if (showDetails) ...[
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.administrator,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                _AdminRoleBadge(role: role),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _AdminRoleBadge extends StatelessWidget {
  const _AdminRoleBadge({required this.role});

  final AdminRole role;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _roleLabel(context, role),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  String _roleLabel(BuildContext context, AdminRole role) {
    final l10n = context.l10n;
    return switch (role) {
      AdminRole.superAdmin => l10n.superAdmin,
      AdminRole.verificationOfficer => l10n.verificationOfficer,
      AdminRole.supportAgent => l10n.supportModerator,
      AdminRole.analyst => l10n.analyst,
    };
  }
}

enum _AdminProfileAction { settings, logout }