import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/profit_distribution_model.dart';

Future<bool> showProfitPayoutDialog(
  BuildContext context,
  ProfitDistributionModel distribution,
) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.triggerPayoutTitle),
        content:
            Text(context.l10n.triggerPayoutMessage(distribution.investorName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.triggerPayout),
          ),
        ],
      ),
    ) ??
    false;
