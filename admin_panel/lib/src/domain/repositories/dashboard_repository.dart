import '../models/dashboard_stats.dart';
import '../models/recent_activity.dart';

abstract class DashboardRepository {
  Future<DashboardStats> fetchDashboardStats();

  Future<List<RecentActivity>> fetchRecentActivities();
}
