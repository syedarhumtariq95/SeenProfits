sealed class DashboardEvent {
  const DashboardEvent();
}

class FetchDashboardData extends DashboardEvent {
  const FetchDashboardData();
}

class RefreshDashboardData extends DashboardEvent {
  const RefreshDashboardData();
}
