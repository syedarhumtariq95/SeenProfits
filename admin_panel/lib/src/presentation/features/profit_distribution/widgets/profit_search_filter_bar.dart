import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/profit_distribution_model.dart';

class ProfitSearchFilterBar extends StatelessWidget {
  const ProfitSearchFilterBar({
    super.key,
    required this.status,
    required this.onSearch,
    required this.onStatusChanged,
  });

  final PayoutStatus? status;
  final ValueChanged<String> onSearch;
  final ValueChanged<PayoutStatus?> onStatusChanged;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 340,
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: context.l10n.searchProfitDistributions,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: DropdownButtonFormField<PayoutStatus?>(
              initialValue: status,
              decoration: InputDecoration(labelText: context.l10n.payoutStatus),
              items: [
                DropdownMenuItem<PayoutStatus?>(
                    value: null, child: Text(context.l10n.allStatuses)),
                for (final value in PayoutStatus.values)
                  DropdownMenuItem(
                    value: value,
                    child: Text(_label(context, value)),
                  ),
              ],
              onChanged: onStatusChanged,
            ),
          ),
        ],
      );

  String _label(BuildContext context, PayoutStatus status) => switch (status) {
        PayoutStatus.pending => context.l10n.pending,
        PayoutStatus.processing => context.l10n.processing,
        PayoutStatus.paid => context.l10n.paid,
        PayoutStatus.failed => context.l10n.failed,
      };
}
