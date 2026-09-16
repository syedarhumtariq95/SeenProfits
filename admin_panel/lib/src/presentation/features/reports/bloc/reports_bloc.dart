import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/reports_repository.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc(this._repository) : super(const ReportsState()) {
    on<FetchAnalyticsData>((event, emit) => _load(emit));
    on<FilterReportsByDateRange>(_onFilter);
    on<ExportReportData>(_onExport);
  }

  final ReportsRepository _repository;

  Future<void> _load(Emitter<ReportsState> emit,
      {DateTime? start, DateTime? end}) async {
    final now = DateTime.now();
    final from = start ?? DateTime(now.year, now.month - 1, now.day);
    final to = end ?? DateTime(now.year, now.month, now.day);
    emit(state.copyWith(
        status: ReportsStatus.loading,
        startDate: from,
        endDate: to,
        clearError: true));
    try {
      final report =
          await _repository.fetchAnalyticsReport(startDate: from, endDate: to);
      emit(state.copyWith(status: ReportsStatus.success, report: report));
    } catch (_) {
      emit(state.copyWith(
          status: ReportsStatus.failure,
          errorMessage: 'Unable to load analytics data.'));
    }
  }

  Future<void> _onFilter(
          FilterReportsByDateRange event, Emitter<ReportsState> emit) =>
      _load(emit, start: event.startDate, end: event.endDate);

  Future<void> _onExport(
      ExportReportData event, Emitter<ReportsState> emit) async {
    final report = state.report;
    if (report == null) return;
    emit(state.copyWith(exportStatus: ReportExportStatus.loading));
    try {
      final response = await _repository.exportReportData(
          report: report, format: event.format);
      emit(state.copyWith(
          exportStatus: ReportExportStatus.success,
          exportedFileName: response.fileName));
    } catch (_) {
      emit(state.copyWith(exportStatus: ReportExportStatus.failure));
    }
  }
}
