class AnalyticsReportModel {
  const AnalyticsReportModel({
    required this.startDate,
    required this.endDate,
    required this.totalPlatformVolume,
    required this.dealSuccessRate,
    required this.totalUsers,
    required this.newUsers,
    required this.activeUsers,
    required this.totalRevenue,
    required this.platformRevenue,
    required this.volumeTrend,
    required this.userGrowthTrend,
    required this.revenueTrend,
  });

  final DateTime startDate;
  final DateTime endDate;
  final double totalPlatformVolume;
  final double dealSuccessRate;
  final int totalUsers;
  final int newUsers;
  final int activeUsers;
  final double totalRevenue;
  final double platformRevenue;
  final List<AnalyticsTrendPoint> volumeTrend;
  final List<AnalyticsTrendPoint> userGrowthTrend;
  final List<AnalyticsTrendPoint> revenueTrend;
}

class AnalyticsTrendPoint {
  const AnalyticsTrendPoint({required this.label, required this.value});

  final String label;
  final double value;
}

class ReportExportResponse {
  const ReportExportResponse({required this.fileName, required this.format});

  final String fileName;
  final String format;
}
