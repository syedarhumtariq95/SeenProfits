import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/profit_distribution_model.dart';

class ProfitDistributionTable extends StatelessWidget {
  const ProfitDistributionTable({
    super.key,
    required this.distributions,
    required this.processingId,
    required this.onAction,
  });

  final List<ProfitDistributionModel> distributions;
  final String? processingId;
  final ValueChanged<ProfitDistributionModel> onAction;

  @override
  Widget build(BuildContext context) => Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text(context.l10n.businessName)),
              DataColumn(label: Text(context.l10n.investor)),
              DataColumn(label: Text(context.l10n.totalProfit)),
              DataColumn(label: Text(context.l10n.investorYield)),
              DataColumn(label: Text(context.l10n.distributionDate)),
              DataColumn(label: Text(context.l10n.payoutStatus)),
              DataColumn(label: Text(context.l10n.actions)),
            ],
            rows: [for (final item in distributions) _row(context, item)],
          ),
        ),
      );

  DataRow _row(BuildContext context, ProfitDistributionModel item) {
    final currency = NumberFormat.currency(
      locale: Localizations.localeOf(context).toString(),
      name: 'PKR',
      decimalDigits: 0,
    );
    final busy = processingId == item.id;
    return DataRow(cells: [
      DataCell(Text(item.businessName)),
      DataCell(Text(item.investorName)),
      DataCell(Text(currency.format(item.totalProfit))),
      DataCell(Text(currency.format(item.investorYield))),
      DataCell(Text(DateFormat.yMMMd(Localizations.localeOf(context).toString())
          .format(item.distributionDate))),
      DataCell(_StatusChip(status: item.status)),
      DataCell(
        item.status == PayoutStatus.paid
            ? Text(context.l10n.completed)
            : TextButton.icon(
                onPressed: busy ? null : () => onAction(item),
                icon: busy
                    ? const SizedBox.square(
                        dimension: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.payments_outlined),
                label: Text(item.status == PayoutStatus.failed
                    ? context.l10n.retryPayout
                    : context.l10n.triggerPayout),
              ),
      ),
    ]);
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final PayoutStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final label = switch (status) {
      PayoutStatus.pending => l10n.pending,
      PayoutStatus.processing => l10n.processing,
      PayoutStatus.paid => l10n.paid,
      PayoutStatus.failed => l10n.failed,
    };
    final color = switch (status) {
      PayoutStatus.pending => Colors.orange,
      PayoutStatus.processing => Colors.blue,
      PayoutStatus.paid => Colors.green,
      PayoutStatus.failed => Colors.red,
    };
    return Chip(
      label: Text(label),
      avatar: Icon(Icons.circle, size: 10, color: color),
    );
  }
}
