import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../bloc/deal_bloc.dart';
import '../bloc/deal_event.dart';
import '../bloc/deal_state.dart';
import 'deal_card.dart';
import 'deal_shimmer.dart';

class DealList extends StatelessWidget {
  const DealList({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DealBloc, DealState>(builder: (context, state) {
        if (state.loadStatus == DealLoadStatus.loading ||
            state.loadStatus == DealLoadStatus.initial) {
          return const DealShimmer();
        }
        if (state.loadStatus == DealLoadStatus.failure) {
          return Center(
              child: OutlinedButton.icon(
                  onPressed: () =>
                      context.read<DealBloc>().add(const FetchDeals()),
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.retry)));
        }
        if (state.visibleDeals.isEmpty) {
          return Center(child: Text(context.l10n.noDealsFound));
        }
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.visibleDeals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final deal = state.visibleDeals[index];
              return DealCard(
                  deal: deal, isLoading: state.processingId == deal.id);
            });
      });
}
