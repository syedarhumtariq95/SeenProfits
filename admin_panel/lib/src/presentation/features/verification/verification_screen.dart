import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/verification_bloc.dart';
import 'bloc/verification_event.dart';
import 'bloc/verification_state.dart';
import 'widgets/verification_request_list.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<VerificationBloc>()
          ..add(const FetchPendingVerifications()),
        child: const _VerificationView(),
      );
}

class _VerificationView extends StatelessWidget {
  const _VerificationView();

  @override
  Widget build(BuildContext context) =>
      BlocListener<VerificationBloc, VerificationState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus &&
            current.actionStatus != VerificationActionStatus.loading,
        listener: (context, state) {
          final message = state.actionStatus == VerificationActionStatus.success
              ? context.l10n.verificationActionSuccess
              : context.l10n.verificationActionFailed;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminPageHeader(title: context.l10n.verificationQueue),
              const SizedBox(height: 24),
              const VerificationRequestList(),
            ],
          ),
        ),
      );
}
