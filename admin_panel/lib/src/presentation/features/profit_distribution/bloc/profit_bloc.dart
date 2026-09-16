import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/profit_distribution_model.dart';
import '../../../../domain/repositories/profit_repository.dart';
import 'profit_event.dart';
import 'profit_state.dart';

class ProfitBloc extends Bloc<ProfitEvent, ProfitState> {
  ProfitBloc(this._repository) : super(const ProfitState()) {
    on<FetchProfitDistributions>(_onFetch);
    on<FilterProfitByStatus>((event, emit) => emit(state.copyWith(
          statusFilter: event.status,
          clearStatusFilter: event.status == null,
        )));
    on<SearchProfitDistributions>(
        (event, emit) => emit(state.copyWith(searchQuery: event.query)));
    on<TriggerProfitDistribution>((event, emit) => _process(
        event.distributionId,
        () => _repository.triggerProfitDistribution(event.distributionId),
        emit));
    on<UpdateProfitPayout>((event, emit) => _process(
        event.distributionId,
        () =>
            _repository.updatePayoutStatus(event.distributionId, event.status),
        emit));
  }

  final ProfitRepository _repository;

  Future<void> _onFetch(
    FetchProfitDistributions event,
    Emitter<ProfitState> emit,
  ) async {
    emit(state.copyWith(loadStatus: ProfitLoadStatus.loading));
    try {
      emit(state.copyWith(
        loadStatus: ProfitLoadStatus.success,
        distributions: await _repository.fetchProfitDistributions(),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: ProfitLoadStatus.failure));
    }
  }

  Future<void> _process(
    String id,
    Future<ProfitDistributionModel> Function() action,
    Emitter<ProfitState> emit,
  ) async {
    emit(state.copyWith(
      actionStatus: ProfitActionStatus.loading,
      processingId: id,
    ));
    try {
      final updated = await action();
      final distributions = state.distributions
          .map((item) => item.id == updated.id ? updated : item)
          .toList(growable: false);
      emit(state.copyWith(
        actionStatus: ProfitActionStatus.success,
        distributions: distributions,
        clearProcessingId: true,
      ));
    } catch (_) {
      emit(state.copyWith(
        actionStatus: ProfitActionStatus.failure,
        clearProcessingId: true,
      ));
    }
  }
}
