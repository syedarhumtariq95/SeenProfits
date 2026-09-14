import '../../../../domain/models/dashboard_stats.dart';
import '../../../../domain/models/recent_activity.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.stats,
    this.activities = const [],
    this.errorMessage,
  });

  final DashboardStatus status;
  final DashboardStats? stats;
  final List<RecentActivity> activities;
  final String? errorMessage;

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardStats? stats,
    List<RecentActivity>? activities,
    String? errorMessage,
    bool clearError = false,
  }) =>
      DashboardState(
        status: status ?? this.status,
        stats: stats ?? this.stats,
        activities: activities ?? this.activities,
        errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      );
}
