import 'package:flutter/material.dart';

import '../../configs/localization/localization_extensions.dart';
import '../../core/permissions/admin_permissions.dart';
import 'admin_routes.dart';

class AdminNavigationItem {
  const AdminNavigationItem({
    required this.route,
    required this.icon,
    required this.label,
    required this.permission,
  });

  final String route;
  final IconData icon;
  final String Function(BuildContext context) label;
  final AdminPermission permission;
}

final List<AdminNavigationItem> adminNavigationItems = [
  AdminNavigationItem(
    route: AdminRouteNames.dashboard,
    icon: Icons.space_dashboard_outlined,
    label: (context) => context.l10n.dashboard,
    permission: AdminPermission.viewDashboard,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.businesses,
    icon: Icons.storefront_outlined,
    label: (context) => context.l10n.businessManagement,
    permission: AdminPermission.reviewBusinesses,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.verification,
    icon: Icons.verified_user_outlined,
    label: (context) => context.l10n.verificationQueue,
    permission: AdminPermission.reviewBusinesses,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.investors,
    icon: Icons.account_balance_outlined,
    label: (context) => context.l10n.investorManagement,
    permission: AdminPermission.manageUsers,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.businessOwners,
    icon: Icons.people_outline,
    label: (context) => context.l10n.businessOwners,
    permission: AdminPermission.manageUsers,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.investmentRequests,
    icon: Icons.request_page_outlined,
    label: (context) => context.l10n.investmentRequests,
    permission: AdminPermission.monitorInvestmentRequests,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.reports,
    icon: Icons.flag_outlined,
    label: (context) => context.l10n.reportsAndComplaints,
    permission: AdminPermission.resolveReports,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.categories,
    icon: Icons.category_outlined,
    label: (context) => context.l10n.categories,
    permission: AdminPermission.manageCategories,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.notifications,
    icon: Icons.notifications_outlined,
    label: (context) => context.l10n.notifications,
    permission: AdminPermission.manageNotifications,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.content,
    icon: Icons.article_outlined,
    label: (context) => context.l10n.content,
    permission: AdminPermission.manageContent,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.analytics,
    icon: Icons.insights_outlined,
    label: (context) => context.l10n.analytics,
    permission: AdminPermission.viewAnalytics,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.auditLogs,
    icon: Icons.history_outlined,
    label: (context) => context.l10n.systemAuditLogs,
    permission: AdminPermission.viewAuditLogs,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.adminAccounts,
    icon: Icons.admin_panel_settings_outlined,
    label: (context) => context.l10n.adminAccounts,
    permission: AdminPermission.manageAdminAccounts,
  ),
  AdminNavigationItem(
    route: AdminRouteNames.settings,
    icon: Icons.settings_outlined,
    label: (context) => context.l10n.adminSettings,
    permission: AdminPermission.manageSettings,
  ),
];
