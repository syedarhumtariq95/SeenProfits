import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/dashboard_stats.dart';
import '../../../../domain/models/recent_activity.dart';
import '../../../../domain/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._repository) : super(const DashboardState()) {
    on<FetchDashboardData>(_onFetchDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
  }

  final DashboardRepository _repository;

  Future<void> _onFetchDashboardData(
    FetchDashboardData event,
    Emitter<DashboardState> emit,
  ) =>
      _loadData(emit);

  Future<void> _onRefreshDashboardData(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) =>
      _loadData(emit);

  Future<void> _loadData(Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: DashboardStatus.loading, clearError: true));
    try {
      final results = await Future.wait<Object>([
        _repository.fetchDashboardStats(),
        _repository.fetchRecentActivities(),
      ]);
      emit(state.copyWith(
        status: DashboardStatus.success,
        stats: results[0] as DashboardStats,
        activities: results[1] as List<RecentActivity>,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: DashboardStatus.failure,
        errorMessage: 'Unable to load dashboard data.',
      ));
    }
  }
}
