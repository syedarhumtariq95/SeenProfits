import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/profit_distribution_model.dart';

class ProfitSummaryCard extends StatelessWidget {
  const ProfitSummaryCard({super.key, required this.distributions});
  final List<ProfitDistributionModel> distributions;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.compactSimpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      name: 'PKR',
      decimalDigits: 1,
    );
    final total = distributions.fold<double>(
      0,
      (sum, item) => sum + item.totalProfit,
    );
    final paid = distributions
        .where((item) => item.status == PayoutStatus.paid)
        .fold<double>(0, (sum, item) => sum + item.investorYield);
    final pending =
        distributions.where((item) => item.status != PayoutStatus.paid).length;
    final cards = [
      (context.l10n.totalProfit, currency.format(total), Icons.trending_up),
      (
        context.l10n.investorPayouts,
        currency.format(paid),
        Icons.payments_outlined
      ),
      (context.l10n.pendingPayouts, pending.toString(), Icons.pending_actions),
    ];
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        crossAxisCount: constraints.maxWidth >= 760 ? 3 : 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: constraints.maxWidth >= 760 ? 2.5 : 4.2,
        children: [
          for (final card in cards)
            Card(
              child: ListTile(
                leading: Icon(card.$3,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text(card.$1),
                subtitle: Text(card.$2,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
        ],
      ),
    );
  }
}
