import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../domain/models/profit_distribution_model.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/profit_bloc.dart';
import 'bloc/profit_event.dart';
import 'bloc/profit_state.dart';
import 'widgets/profit_distribution_shimmer.dart';
import 'widgets/profit_distribution_table.dart';
import 'widgets/profit_payout_dialog.dart';
import 'widgets/profit_search_filter_bar.dart';
import 'widgets/profit_summary_card.dart';

class ProfitDistributionScreen extends StatelessWidget {
  const ProfitDistributionScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<ProfitBloc>()
          ..add(const FetchProfitDistributions()),
        child: const _ProfitDistributionView(),
      );
}

class _ProfitDistributionView extends StatelessWidget {
  const _ProfitDistributionView();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<ProfitBloc, ProfitState>(
          listenWhen: (previous, current) =>
              previous.actionStatus != current.actionStatus &&
              current.actionStatus == ProfitActionStatus.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(context.l10n.payoutFailed))),
          builder: (context, state) {
            final l10n = context.l10n;
            if (state.loadStatus == ProfitLoadStatus.failure &&
                state.distributions.isEmpty) {
              return _ErrorView(
                  onRetry: () => context
                      .read<ProfitBloc>()
                      .add(const FetchProfitDistributions()));
            }
            final loading = state.loadStatus == ProfitLoadStatus.initial ||
                state.loadStatus == ProfitLoadStatus.loading;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminPageHeader(title: l10n.profitDistribution),
                const SizedBox(height: 20),
                ProfitSummaryCard(distributions: state.distributions),
                const SizedBox(height: 20),
                ProfitSearchFilterBar(
                  status: state.statusFilter,
                  onSearch: (query) => context
                      .read<ProfitBloc>()
                      .add(SearchProfitDistributions(query)),
                  onStatusChanged: (status) => context
                      .read<ProfitBloc>()
                      .add(FilterProfitByStatus(status)),
                ),
                const SizedBox(height: 16),
                if (loading && state.distributions.isEmpty)
                  const ProfitDistributionShimmer()
                else if (state.visibleDistributions.isEmpty)
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text(l10n.noProfitDistributions),
                  ))
                else
                  ProfitDistributionTable(
                    distributions: state.visibleDistributions,
                    processingId: state.processingId,
                    onAction: (item) => _confirmAction(context, item),
                  ),
              ],
            );
          },
        ),
      );

  Future<void> _confirmAction(
    BuildContext context,
    ProfitDistributionModel distribution,
  ) async {
    if (!await showProfitPayoutDialog(context, distribution)) return;
    if (context.mounted) {
      context.read<ProfitBloc>().add(
            TriggerProfitDistribution(distribution.id),
          );
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 44),
            const SizedBox(height: 12),
            Text(context.l10n.profitLoadFailed),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      );
}
