import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/deal_model.dart';
import '../bloc/deal_bloc.dart';
import '../bloc/deal_event.dart';

class DealSearchFilterBar extends StatelessWidget {
  const DealSearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final search = TextField(
            onChanged: (value) =>
                context.read<DealBloc>().add(SearchDeals(value)),
            decoration: InputDecoration(
              hintText: context.l10n.searchDeals,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          );
          final filter = DropdownButtonFormField<DealStatus?>(
            initialValue: null,
            decoration: InputDecoration(
                labelText: context.l10n.dealStatus,
                border: const OutlineInputBorder()),
            items: [
              DropdownMenuItem<DealStatus?>(
                  value: null, child: Text(context.l10n.allStatuses)),
              ...DealStatus.values.map((status) => DropdownMenuItem(
                  value: status, child: Text(status.label(context)))),
            ],
            onChanged: (status) =>
                context.read<DealBloc>().add(FilterDealsByStatus(status)),
          );
          return constraints.maxWidth < 620
              ? Column(children: [search, const SizedBox(height: 12), filter])
              : Row(children: [
                  Expanded(child: search),
                  const SizedBox(width: 16),
                  SizedBox(width: 220, child: filter)
                ]);
        },
      );
}

extension on DealStatus {
  String label(BuildContext context) => switch (this) {
        DealStatus.pending => context.l10n.pending,
        DealStatus.approved => context.l10n.approved,
        DealStatus.rejected => context.l10n.rejected,
        DealStatus.active => context.l10n.active,
        DealStatus.completed => context.l10n.completed,
      };
}
