import '../../domain/models/dashboard_stats.dart';
import '../../domain/models/recent_activity.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// In-memory dashboard data source that mimics a remote analytics API.
class MockDashboardRepositoryImpl implements DashboardRepository {
  MockDashboardRepositoryImpl({
    this.networkLatency = const Duration(milliseconds: 650),
  });

  final Duration networkLatency;

  @override
  Future<DashboardStats> fetchDashboardStats() async {
    await _simulateNetworkRequest();
    return const DashboardStats(
      totalBusinesses: 128,
      activeBusinesses: 96,
      pendingBusinesses: 14,
      suspendedBusinesses: 18,
      totalRevenue: 2847500,
      monthlyGrowthPercentage: 12.4,
    );
  }

  @override
  Future<List<RecentActivity>> fetchRecentActivities() async {
    await _simulateNetworkRequest();
    final now = DateTime.now();
    return [
      RecentActivity(
        id: 'activity-1',
        type: RecentActivityType.businessApproved,
        subject: 'Alpha Foods',
        occurredAt: now.subtract(const Duration(minutes: 18)),
      ),
      RecentActivity(
        id: 'activity-2',
        type: RecentActivityType.businessSubmitted,
        subject: 'Greenfield Farms',
        occurredAt: now.subtract(const Duration(hours: 2)),
      ),
      RecentActivity(
        id: 'activity-3',
        type: RecentActivityType.revenueReceived,
        subject: 'PKR 85,000',
        occurredAt: now.subtract(const Duration(hours: 5)),
      ),
      RecentActivity(
        id: 'activity-4',
        type: RecentActivityType.businessSuspended,
        subject: 'Vertex Labs',
        occurredAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  Future<void> _simulateNetworkRequest() =>
      Future<void>.delayed(networkLatency);
}
