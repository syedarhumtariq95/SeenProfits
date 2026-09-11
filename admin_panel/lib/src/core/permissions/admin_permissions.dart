enum AdminRole { superAdmin, verificationOfficer, supportAgent, analyst }

enum AdminPermission {
  viewDashboard,
  reviewBusinesses,
  manageUsers,
  monitorInvestmentRequests,
  manageCategories,
  resolveReports,
  manageNotifications,
  manageContent,
  viewAnalytics,
  viewAuditLogs,
  manageAdminAccounts,
  manageSettings,
}

extension AdminRolePermissions on AdminRole {
  Set<AdminPermission> get permissions {
    switch (this) {
      case AdminRole.superAdmin:
        return AdminPermission.values.toSet();
      case AdminRole.verificationOfficer:
        return {
          AdminPermission.viewDashboard,
          AdminPermission.reviewBusinesses,
        };
      case AdminRole.supportAgent:
        return {
          AdminPermission.viewDashboard,
          AdminPermission.manageUsers,
          AdminPermission.resolveReports,
        };
      case AdminRole.analyst:
        return {
          AdminPermission.viewDashboard,
          AdminPermission.viewAnalytics,
        };
    }
  }
}
