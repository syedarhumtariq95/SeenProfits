sealed class ReportsEvent {
  const ReportsEvent();
}

class FetchAnalyticsData extends ReportsEvent {
  const FetchAnalyticsData();
}

class FilterReportsByDateRange extends ReportsEvent {
  const FilterReportsByDateRange(this.startDate, this.endDate);

  final DateTime startDate;
  final DateTime endDate;
}

class ExportReportData extends ReportsEvent {
  const ExportReportData(this.format);

  final String format;
}
