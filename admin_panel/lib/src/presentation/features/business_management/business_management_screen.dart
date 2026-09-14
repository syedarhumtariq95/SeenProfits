import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../core/responsive/admin_breakpoints.dart';
import '../../../domain/models/business_details.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/business_bloc.dart';
import 'bloc/business_event.dart';
import 'bloc/business_state.dart';
import 'widgets/business_details_modal.dart';

class BusinessManagementScreen extends StatelessWidget {
  const BusinessManagementScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<BusinessBloc>()
          ..add(const FetchBusinesses()),
        child: const _BusinessManagementView(),
      );
}

class _BusinessManagementView extends StatelessWidget {
  const _BusinessManagementView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AdminPageHeader(title: l10n.businessManagement),
        const SizedBox(height: 24),
        const _BusinessFilters(),
        const SizedBox(height: 20),
        const _BusinessTable(),
      ]),
    );
  }
}

class _BusinessFilters extends StatelessWidget {
  const _BusinessFilters();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedStatus =
        context.select((BusinessBloc bloc) => bloc.state.status);
    final search = TextField(
      onChanged: (query) =>
          context.read<BusinessBloc>().add(SearchBusinesses(query)),
      decoration: InputDecoration(
          hintText: l10n.searchBusinesses,
          prefixIcon: const Icon(Icons.search)),
    );
    final filter = DropdownButtonFormField<BusinessStatus?>(
      initialValue: selectedStatus,
      decoration: InputDecoration(labelText: l10n.businessStatus),
      items: [
        DropdownMenuItem(value: null, child: Text(l10n.allStatuses)),
        ...BusinessStatus.values.map((status) => DropdownMenuItem(
            value: status, child: Text(_statusLabel(l10n, status)))),
      ],
      onChanged: (status) =>
          context.read<BusinessBloc>().add(FilterBusinesses(status)),
    );
    return LayoutBuilder(
      builder: (context, constraints) =>
          constraints.maxWidth >= AdminBreakpoints.tablet
              ? Row(children: [
                  Expanded(child: search),
                  const SizedBox(width: 16),
                  SizedBox(width: 220, child: filter)
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [search, const SizedBox(height: 16), filter]),
    );
  }
}

class _BusinessTable extends StatelessWidget {
  const _BusinessTable();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state.loadStatus == BusinessLoadStatus.initial ||
              state.loadStatus == BusinessLoadStatus.loading) {
            return const _BusinessTableShimmer();
          }
          final l10n = context.l10n;
          if (state.loadStatus == BusinessLoadStatus.failure) {
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                        child: OutlinedButton.icon(
                      onPressed: () => context
                          .read<BusinessBloc>()
                          .add(const FetchBusinesses()),
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.retry),
                    ))));
          }
          return Card(
            clipBehavior: Clip.antiAlias,
            child: state.businesses.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(l10n.noBusinessesFound))
                : LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: constraints.maxWidth < 760
                                    ? 760
                                    : constraints.maxWidth),
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text(l10n.businessName)),
                                DataColumn(label: Text(l10n.owner)),
                                DataColumn(label: Text(l10n.category)),
                                DataColumn(label: Text(l10n.businessStatus)),
                                DataColumn(label: Text(l10n.actions)),
                              ],
                              rows: state.businesses
                                  .map((business) =>
                                      _buildRow(context, business))
                                  .toList(),
                            ),
                          ),
                        )),
          );
        },
      );

  DataRow _buildRow(BuildContext context, BusinessDetails business) {
    final l10n = context.l10n;
    return DataRow(cells: [
      DataCell(Text(business.name)),
      DataCell(Text(business.owner)),
      DataCell(Text(_categoryLabel(l10n, business.category))),
      DataCell(_StatusChip(status: business.status)),
      DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            tooltip: l10n.viewBusiness,
            onPressed: () => showBusinessDetailsModal(
                context: context, details: business, isEditing: false),
            icon: const Icon(Icons.visibility_outlined)),
        IconButton(
            tooltip: l10n.editBusiness,
            onPressed: () => showBusinessDetailsModal(
                context: context, details: business, isEditing: true),
            icon: const Icon(Icons.edit_outlined)),
      ])),
    ]);
  }
}

class _BusinessTableShimmer extends StatelessWidget {
  const _BusinessTableShimmer();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
          children: List.generate(
              5,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FractionallySizedBox(
                          widthFactor: index.isEven ? .9 : .65,
                          child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(6))),
                        )),
                  ))),
    ));
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final BusinessStatus status;
  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BusinessStatus.active => Colors.green,
      BusinessStatus.suspended => Colors.red,
      BusinessStatus.pending => Colors.orange
    };
    return Chip(
        label: Text(_statusLabel(context.l10n, status)),
        labelStyle: TextStyle(color: color),
        side: BorderSide(color: color.withValues(alpha: 0.5)),
        backgroundColor: color.withValues(alpha: 0.12),
        visualDensity: VisualDensity.compact);
  }
}

String _statusLabel(AppLocalizations l10n, BusinessStatus status) =>
    switch (status) {
      BusinessStatus.active => l10n.active,
      BusinessStatus.suspended => l10n.suspended,
      BusinessStatus.pending => l10n.pending
    };
String _categoryLabel(AppLocalizations l10n, BusinessCategory category) =>
    switch (category) {
      BusinessCategory.foodAndBeverage => l10n.foodAndBeverage,
      BusinessCategory.technology => l10n.technology,
      BusinessCategory.agriculture => l10n.agriculture,
      BusinessCategory.manufacturing => l10n.manufacturing
    };
