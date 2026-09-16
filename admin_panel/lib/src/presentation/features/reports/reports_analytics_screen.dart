import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../core/responsive/admin_breakpoints.dart';
import '../../../domain/models/analytics_report_model.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/reports_bloc.dart';
import 'bloc/reports_event.dart';
import 'bloc/reports_state.dart';
import 'widgets/date_range_filter.dart';
import 'widgets/metric_summary_card.dart';
import 'widgets/report_export_dialog.dart';
import 'widgets/reports_shimmer.dart';
import 'widgets/trend_chart.dart';

class ReportsAnalyticsScreen extends StatelessWidget {
  const ReportsAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<ReportsBloc>()
          ..add(const FetchAnalyticsData()),
        child: const _ReportsView(),
      );
}

class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(24),
      child: BlocConsumer<ReportsBloc, ReportsState>(
        listener: (context, state) {
          if (state.exportStatus == ReportExportStatus.success &&
              state.exportedFileName != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    context.l10n.reportExported(state.exportedFileName!))));
          }
        },
        builder: (context, state) {
          final l10n = context.l10n;
          final report = state.report;
          if (state.status == ReportsStatus.failure && report == null) {
            return Center(child: Text(l10n.reportsLoadFailed));
          }
          final loading =
              report == null || state.status == ReportsStatus.loading;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                      child: AdminPageHeader(title: l10n.reportsAnalytics)),
                  if (!loading)
                    DateRangeFilter(
                        startDate: state.startDate!,
                        endDate: state.endDate!,
                        onChanged: (start, end) => context
                            .read<ReportsBloc>()
                            .add(FilterReportsByDateRange(start, end))),
                  const SizedBox(width: 8),
                  IconButton(
                      onPressed: loading ? null : () => _export(context),
                      tooltip: l10n.exportReport,
                      icon: const Icon(Icons.download_outlined))
                ]),
                const SizedBox(height: 24),
                if (loading)
                  const ReportsShimmer()
                else
                  _ReportContent(report: report),
              ]);
        },
      ));

  Future<void> _export(BuildContext context) async {
    final format = await showReportExportDialog(context);
    if (format != null && context.mounted) {
      context.read<ReportsBloc>().add(ExportReportData(format));
    }
  }
}

class _ReportContent extends StatelessWidget {
  const _ReportContent({required this.report});
  final AnalyticsReportModel report;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final currency = NumberFormat.compactSimpleCurrency(
        locale: locale, name: 'PKR', decimalDigits: 1);
    final number = NumberFormat.decimalPattern(locale);
    final metrics = [
      MetricSummaryCard(
          label: context.l10n.platformVolume,
          value: currency.format(report.totalPlatformVolume),
          icon: Icons.swap_vert_circle_outlined),
      MetricSummaryCard(
          label: context.l10n.dealSuccessRate,
          value: '${report.dealSuccessRate.toStringAsFixed(1)}%',
          icon: Icons.track_changes_outlined),
      MetricSummaryCard(
          label: context.l10n.totalUsers,
          value: number.format(report.totalUsers),
          icon: Icons.people_outline),
      MetricSummaryCard(
          label: context.l10n.newUsers,
          value: number.format(report.newUsers),
          icon: Icons.person_add_alt_outlined),
      MetricSummaryCard(
          label: context.l10n.totalRevenue,
          value: currency.format(report.totalRevenue),
          icon: Icons.payments_outlined),
      MetricSummaryCard(
          label: context.l10n.platformRevenue,
          value: currency.format(report.platformRevenue),
          icon: Icons.account_balance_wallet_outlined),
    ];
    return Column(children: [
      LayoutBuilder(
          builder: (context, constraints) => GridView.count(
              crossAxisCount: constraints.maxWidth >= 1040
                  ? 3
                  : constraints.maxWidth >= AdminBreakpoints.tablet
                      ? 2
                      : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: metrics)),
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, constraints) {
        final charts = [
          TrendChart(
              title: context.l10n.volumeTrend,
              points: report.volumeTrend,
              valueSuffix: 'M'),
          TrendChart(
              title: context.l10n.userGrowth,
              points: report.userGrowthTrend,
              valueSuffix: 'k'),
          TrendChart(
              title: context.l10n.revenueTrend,
              points: report.revenueTrend,
              valueSuffix: 'M')
        ];
        return constraints.maxWidth >= AdminBreakpoints.tablet
            ? Row(children: [
                for (final chart in charts)
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12),
                          child: chart))
              ])
            : Column(children: charts);
      }),
    ]);
  }
}
