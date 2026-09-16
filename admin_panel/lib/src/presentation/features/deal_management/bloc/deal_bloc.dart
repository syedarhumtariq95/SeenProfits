import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/deal_model.dart';
import '../../../../domain/repositories/deal_repository.dart';
import 'deal_event.dart';
import 'deal_state.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  DealBloc(this._repository) : super(const DealState()) {
    on<FetchDeals>(_onFetch);
    on<SearchDeals>((event, emit) => emit(state.copyWith(query: event.query)));
    on<FilterDealsByStatus>((event, emit) => emit(state.copyWith(
          statusFilter: event.status,
          clearStatusFilter: event.status == null,
        )));
    on<ApproveProposal>((event, emit) => _process(
        event.dealId, _repository.approveProposal, DealStatus.approved, emit));
    on<RejectProposal>((event, emit) => _process(
        event.dealId, _repository.rejectProposal, DealStatus.rejected, emit));
  }

  final DealRepository _repository;

  Future<void> _onFetch(FetchDeals event, Emitter<DealState> emit) async {
    emit(state.copyWith(loadStatus: DealLoadStatus.loading));
    try {
      emit(state.copyWith(
          loadStatus: DealLoadStatus.success,
          deals: await _repository.fetchDeals()));
    } catch (_) {
      emit(state.copyWith(loadStatus: DealLoadStatus.failure));
    }
  }

  Future<void> _process(
    String id,
    Future<void> Function(String) action,
    DealStatus resultStatus,
    Emitter<DealState> emit,
  ) async {
    emit(state.copyWith(
        actionStatus: DealActionStatus.loading, processingId: id));
    try {
      await action(id);
      final deals = state.deals
          .map((deal) =>
              deal.id == id ? deal.copyWith(status: resultStatus) : deal)
          .toList(growable: false);
      emit(state.copyWith(
          actionStatus: DealActionStatus.success,
          deals: deals,
          clearProcessingId: true));
    } catch (_) {
      emit(state.copyWith(
          actionStatus: DealActionStatus.failure, clearProcessingId: true));
    }
  }
}
