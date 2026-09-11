import 'package:flutter/material.dart';

import '../../../configs/localization/localization_extensions.dart';
import '../../../configs/router/admin_routes.dart';
import '../../../core/responsive/admin_breakpoints.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'widgets/dashboard_metric_card.dart';
import 'widgets/dashboard_quick_action.dart';

class DashboardPlaceholderScreen extends StatelessWidget {
  const DashboardPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminPageHeader(title: l10n.dashboard),
          const SizedBox(height: 24),
          Text(l10n.mockDashboardDataNotice),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1040
                  ? 4
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
                  DashboardMetricCard(
                    label: l10n.totalBusinesses,
                    value: '128',
                    icon: Icons.storefront_outlined,
                  ),
                  DashboardMetricCard(
                    label: l10n.pendingVerifications,
                    value: '14',
                    icon: Icons.verified_user_outlined,
                  ),
                  DashboardMetricCard(
                    label: l10n.activeInvestors,
                    value: '342',
                    icon: Icons.account_balance_outlined,
                  ),
                  DashboardMetricCard(
                    label: l10n.totalInvestmentRequests,
                    value: '76',
                    icon: Icons.request_page_outlined,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= AdminBreakpoints.tablet;
              final activityCard = _RecentActivityCard();
              final actionsCard = _QuickActionsCard();
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: activityCard),
                        const SizedBox(width: 16),
                        Expanded(flex: 2, child: actionsCard),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [activityCard, const SizedBox(height: 16), actionsCard],
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.recentActivity, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(l10n.recentActivityPlaceholder),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.quickActions, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DashboardQuickAction(
              label: l10n.reviewPendingBusiness,
              icon: Icons.verified_user_outlined,
              onPressed: () => Navigator.of(context).pushNamed(
                AdminRouteNames.verification,
              ),
            ),
            const SizedBox(height: 12),
            DashboardQuickAction(
              label: l10n.viewReports,
              icon: Icons.flag_outlined,
              onPressed: () => Navigator.of(context).pushNamed(
                AdminRouteNames.reports,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
