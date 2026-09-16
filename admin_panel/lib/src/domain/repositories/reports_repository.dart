import '../models/analytics_report_model.dart';

abstract class ReportsRepository {
  Future<AnalyticsReportModel> fetchAnalyticsReport({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<ReportExportResponse> exportReportData({
    required AnalyticsReportModel report,
    required String format,
  });
}
