class DashboardStats {
  const DashboardStats({
    required this.totalBusinesses,
    required this.activeBusinesses,
    required this.pendingBusinesses,
    required this.suspendedBusinesses,
    required this.totalRevenue,
    required this.monthlyGrowthPercentage,
  });

  final int totalBusinesses;
  final int activeBusinesses;
  final int pendingBusinesses;
  final int suspendedBusinesses;
  final double totalRevenue;
  final double monthlyGrowthPercentage;
}
