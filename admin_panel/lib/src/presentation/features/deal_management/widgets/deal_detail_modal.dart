import 'package:flutter/material.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/deal_model.dart';

Future<void> showDealDetailModal(BuildContext context, DealModel deal) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.dealDetails),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(deal.businessName,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text('${context.l10n.investor}: ${deal.investorName}'),
              Text(
                  '${context.l10n.investmentAmount}: PKR ${deal.amount.toStringAsFixed(0)}'),
              Text(
                  '${context.l10n.expectedReturn}: ${deal.expectedReturn.toStringAsFixed(0)}%'),
              if (deal.notes != null) ...[
                const SizedBox(height: 12),
                Text(deal.notes!)
              ],
            ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.close))
        ],
      ),
    );
