import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/deal_bloc.dart';
import 'bloc/deal_event.dart';
import 'bloc/deal_state.dart';
import 'widgets/deal_list.dart';
import 'widgets/deal_search_filter_bar.dart';

class DealManagementScreen extends StatelessWidget {
  const DealManagementScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) =>
          AdminDependencyInjection.get<DealBloc>()..add(const FetchDeals()),
      child: const _DealManagementView());
}

class _DealManagementView extends StatelessWidget {
  const _DealManagementView();
  @override
  Widget build(BuildContext context) => BlocListener<DealBloc, DealState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus &&
            current.actionStatus != DealActionStatus.loading,
        listener: (context, state) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
                content: Text(state.actionStatus == DealActionStatus.success
                    ? context.l10n.dealActionSuccess
                    : context.l10n.dealActionFailed))),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AdminPageHeader(title: context.l10n.investmentRequests),
            const SizedBox(height: 24),
            const DealSearchFilterBar(),
            const SizedBox(height: 20),
            const DealList(),
          ]),
        ),
      );
}
