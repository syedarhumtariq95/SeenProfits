import 'package:flutter/material.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/deal_model.dart';
import 'deal_action_dialogs.dart';
import 'deal_detail_modal.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key, required this.deal, required this.isLoading});
  final DealModel deal;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final canReview = deal.status == DealStatus.pending;
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 14,
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                    width: 250,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(deal.businessName,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(
                              '${context.l10n.investor}: ${deal.investorName}'),
                        ])),
                Text('PKR ${deal.amount.toStringAsFixed(0)}'),
                _StatusChip(status: deal.status),
                Wrap(spacing: 8, children: [
                  IconButton(
                      tooltip: context.l10n.viewDeal,
                      onPressed: () => showDealDetailModal(context, deal),
                      icon: const Icon(Icons.visibility_outlined)),
                  if (canReview) ...[
                    FilledButton(
                        onPressed: isLoading
                            ? null
                            : () => showDealActionDialog(context, deal, true),
                        child: isLoading
                            ? const SizedBox.square(
                                dimension: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : Text(context.l10n.approve)),
                    OutlinedButton(
                        onPressed: isLoading
                            ? null
                            : () => showDealActionDialog(context, deal, false),
                        child: Text(context.l10n.reject)),
                  ],
                ]),
              ],
            )));
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final DealStatus status;
  @override
  Widget build(BuildContext context) => Chip(
          label: Text(switch (status) {
        DealStatus.pending => context.l10n.pending,
        DealStatus.approved => context.l10n.approved,
        DealStatus.rejected => context.l10n.rejected,
        DealStatus.active => context.l10n.active,
        DealStatus.completed => context.l10n.completed,
      }));
}
