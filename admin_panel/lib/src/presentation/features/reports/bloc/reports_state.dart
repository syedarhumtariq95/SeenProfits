import '../../../../domain/models/analytics_report_model.dart';

enum ReportsStatus { initial, loading, success, failure }

enum ReportExportStatus { idle, loading, success, failure }

class ReportsState {
  const ReportsState({
    this.status = ReportsStatus.initial,
    this.exportStatus = ReportExportStatus.idle,
    this.report,
    this.startDate,
    this.endDate,
    this.exportedFileName,
    this.errorMessage,
  });

  final ReportsStatus status;
  final ReportExportStatus exportStatus;
  final AnalyticsReportModel? report;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? exportedFileName;
  final String? errorMessage;

  ReportsState copyWith({
    ReportsStatus? status,
    ReportExportStatus? exportStatus,
    AnalyticsReportModel? report,
    DateTime? startDate,
    DateTime? endDate,
    String? exportedFileName,
    String? errorMessage,
    bool clearError = false,
  }) =>
      ReportsState(
        status: status ?? this.status,
        exportStatus: exportStatus ?? this.exportStatus,
        report: report ?? this.report,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        exportedFileName: exportedFileName ?? this.exportedFileName,
        errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      );
}
