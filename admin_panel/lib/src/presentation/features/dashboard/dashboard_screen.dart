import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../configs/router/admin_routes.dart';
import '../../../core/responsive/admin_breakpoints.dart';
import '../../../domain/models/dashboard_stats.dart';
import '../../../domain/models/recent_activity.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'widgets/dashboard_metric_card.dart';
import 'widgets/dashboard_quick_action.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<DashboardBloc>()
          ..add(const FetchDashboardData()),
        child: const _DashboardView(),
      );
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == DashboardStatus.failure && state.stats == null) {
            return _DashboardError(
              message: l10n.dashboardLoadFailed,
              onRetry: () =>
                  context.read<DashboardBloc>().add(const FetchDashboardData()),
            );
          }
          final isLoading = state.status == DashboardStatus.initial ||
              state.status == DashboardStatus.loading;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: AdminPageHeader(title: l10n.dashboard)),
                  IconButton(
                    tooltip: l10n.refreshDashboard,
                    onPressed: isLoading
                        ? null
                        : () => context
                            .read<DashboardBloc>()
                            .add(const RefreshDashboardData()),
                    icon: const Icon(Icons.refresh),
                  ),
                ]),
                const SizedBox(height: 24),
                _MetricsGrid(stats: state.stats, isLoading: isLoading),
                const SizedBox(height: 24),
                LayoutBuilder(builder: (context, constraints) {
                  final activity = _RecentActivityCard(
                      activities: state.activities, isLoading: isLoading);
                  const actions = _QuickActionsCard();
                  return constraints.maxWidth >= AdminBreakpoints.tablet
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Expanded(flex: 3, child: activity),
                              const SizedBox(width: 16),
                              const Expanded(flex: 2, child: actions)
                            ])
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              activity,
                              const SizedBox(height: 16),
                              actions
                            ]);
                }),
              ]);
        },
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.stats, required this.isLoading});
  final DashboardStats? stats;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final numberFormat = NumberFormat.decimalPattern(locale);
    final revenueFormat = NumberFormat.compactSimpleCurrency(
        locale: locale, name: 'PKR', decimalDigits: 1);
    final cards = <(String, String?, IconData)>[
      (
        l10n.totalBusinesses,
        stats == null ? null : numberFormat.format(stats!.totalBusinesses),
        Icons.storefront_outlined
      ),
      (
        l10n.activeBusinesses,
        stats == null ? null : numberFormat.format(stats!.activeBusinesses),
        Icons.check_circle_outline
      ),
      (
        l10n.pendingBusinesses,
        stats == null ? null : numberFormat.format(stats!.pendingBusinesses),
        Icons.hourglass_top_outlined
      ),
      (
        l10n.suspendedBusinesses,
        stats == null ? null : numberFormat.format(stats!.suspendedBusinesses),
        Icons.pause_circle_outline
      ),
      (
        l10n.totalRevenue,
        stats == null ? null : revenueFormat.format(stats!.totalRevenue),
        Icons.account_balance_wallet_outlined
      ),
      (
        l10n.monthlyGrowth,
        stats == null
            ? null
            : '${stats!.monthlyGrowthPercentage.toStringAsFixed(1)}%',
        Icons.trending_up
      ),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth >= 1040
          ? 3
          : constraints.maxWidth >= AdminBreakpoints.tablet
              ? 2
              : 1;
      return GridView.count(
        crossAxisCount: columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: columns == 1 ? 3.2 : 1.55,
        children: [
          for (final card in cards)
            isLoading && stats == null
                ? const _ShimmerMetricCard()
                : DashboardMetricCard(
                    label: card.$1, value: card.$2!, icon: card.$3)
        ],
      );
    });
  }
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard(
      {required this.activities, required this.isLoading});
  final List<RecentActivity> activities;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Card(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(context.l10n.recentActivity,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (isLoading && activities.isEmpty)
            const _ShimmerActivityList()
          else
            for (final activity in activities)
              _ActivityTile(activity: activity),
        ]),
      ));
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});
  final RecentActivity activity;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, title) = switch (activity.type) {
      RecentActivityType.businessApproved => (
          Icons.verified_outlined,
          l10n.businessApprovedActivity(activity.subject)
        ),
      RecentActivityType.businessSubmitted => (
          Icons.add_business_outlined,
          l10n.businessSubmittedActivity(activity.subject)
        ),
      RecentActivityType.businessSuspended => (
          Icons.block_outlined,
          l10n.businessSuspendedActivity(activity.subject)
        ),
      RecentActivityType.revenueReceived => (
          Icons.payments_outlined,
          l10n.revenueReceivedActivity(activity.subject)
        ),
    };
    final elapsed = DateTime.now().difference(activity.occurredAt);
    final time = elapsed.inMinutes < 60
        ? l10n.minutesAgo(elapsed.inMinutes)
        : elapsed.inHours < 24
            ? l10n.hoursAgo(elapsed.inHours)
            : l10n.yesterday;
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
        title: Text(title),
        subtitle: Text(time));
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();
  @override
  Widget build(BuildContext context) => Card(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(context.l10n.quickActions,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          DashboardQuickAction(
              label: context.l10n.reviewPendingBusiness,
              icon: Icons.verified_user_outlined,
              onPressed: () => Navigator.of(context)
                  .pushNamed(AdminRouteNames.verification)),
          const SizedBox(height: 12),
          DashboardQuickAction(
              label: context.l10n.viewReports,
              icon: Icons.flag_outlined,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AdminRouteNames.reports)),
        ]),
      ));
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 96),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error_outline, size: 44),
            const SizedBox(height: 12),
            Text(message),
            const SizedBox(height: 16),
            FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry)),
          ])));
}

class _ShimmerMetricCard extends StatelessWidget {
  const _ShimmerMetricCard();
  @override
  Widget build(BuildContext context) => const Card(
      child: Padding(
          padding: EdgeInsets.all(20), child: _ShimmerBlock(height: 100)));
}

class _ShimmerActivityList extends StatelessWidget {
  const _ShimmerActivityList();
  @override
  Widget build(BuildContext context) => const Column(children: [
        _ShimmerBlock(height: 52),
        SizedBox(height: 12),
        _ShimmerBlock(height: 52),
        SizedBox(height: 12),
        _ShimmerBlock(height: 52)
      ]);
}

class _ShimmerBlock extends StatefulWidget {
  const _ShimmerBlock({required this.height});
  final double height;
  @override
  State<_ShimmerBlock> createState() => _ShimmerBlockState();
}

class _ShimmerBlockState extends State<_ShimmerBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
      opacity: Tween<double>(begin: .35, end: .8).animate(_controller),
      child: Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8))));
}
