import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../domain/models/user_model.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'widgets/user_list.dart';
import 'widgets/user_search_filter_bar.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key, this.initialRole});
  final UserRole? initialRole;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<UserBloc>()
          ..add(const FetchUsers())
          ..add(FilterUsersByRole(initialRole)),
        child: const _UserManagementView(),
      );
}

class _UserManagementView extends StatelessWidget {
  const _UserManagementView();
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AdminPageHeader(title: context.l10n.userManagement),
        const SizedBox(height: 24),
        const UserSearchFilterBar(),
        const SizedBox(height: 20),
        const UserList(),
      ]));
}
