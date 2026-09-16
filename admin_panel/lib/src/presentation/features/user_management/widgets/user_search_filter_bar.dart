import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../../../../domain/models/user_model.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class UserSearchFilterBar extends StatelessWidget {
  const UserSearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.select((UserBloc bloc) => bloc.state.role);
    final search = TextField(
      onChanged: (value) => context.read<UserBloc>().add(SearchUsers(value)),
      decoration: InputDecoration(
        hintText: context.l10n.searchUsers,
        prefixIcon: const Icon(Icons.search),
      ),
    );
    final filter = DropdownButtonFormField<UserRole?>(
      initialValue: role,
      decoration: InputDecoration(labelText: context.l10n.userRole),
      items: [
        DropdownMenuItem(value: null, child: Text(context.l10n.allUsers)),
        DropdownMenuItem(
            value: UserRole.investor, child: Text(context.l10n.investor)),
        DropdownMenuItem(
            value: UserRole.businessOwner,
            child: Text(context.l10n.businessOwner)),
      ],
      onChanged: (value) =>
          context.read<UserBloc>().add(FilterUsersByRole(value)),
    );
    return LayoutBuilder(
      builder: (context, constraints) =>
          constraints.maxWidth >= AdminBreakpoints.tablet
              ? Row(children: [
                  Expanded(child: search),
                  const SizedBox(width: 16),
                  SizedBox(width: 220, child: filter)
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [search, const SizedBox(height: 16), filter]),
    );
  }
}
