import '../../domain/models/analytics_report_model.dart';
import '../../domain/repositories/reports_repository.dart';

class MockReportsRepositoryImpl implements ReportsRepository {
  @override
  Future<AnalyticsReportModel> fetchAnalyticsReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final days = endDate.difference(startDate).inDays.clamp(1, 365);
    final factor = days / 30;
    return AnalyticsReportModel(
      startDate: startDate,
      endDate: endDate,
      totalPlatformVolume: 12850000 * factor,
      dealSuccessRate: 72.4,
      totalUsers: 18420 + (days * 8),
      newUsers: 1240 + (days * 2),
      activeUsers: 12680 + (days * 5),
      totalRevenue: 2847500 * factor,
      platformRevenue: 854250 * factor,
      volumeTrend: _trend([2.1, 2.6, 3.0, 3.8, 4.4, 5.2, 6.1], factor),
      userGrowthTrend: _trend([1.2, 1.8, 2.4, 3.1, 3.9, 4.6, 5.4], 1),
      revenueTrend: _trend([.32, .42, .48, .55, .66, .74, .86], factor),
    );
  }

  List<AnalyticsTrendPoint> _trend(List<double> values, double factor) => [
        for (var index = 0; index < values.length; index++)
          AnalyticsTrendPoint(
              label: 'W${index + 1}', value: values[index] * factor),
      ];

  @override
  Future<ReportExportResponse> exportReportData({
    required AnalyticsReportModel report,
    required String format,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return ReportExportResponse(
      fileName:
          'seen-profits-report-${report.endDate.millisecondsSinceEpoch}.$format',
      format: format,
    );
  }
}
