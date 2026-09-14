import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/verification_repository.dart';
import 'verification_event.dart';
import 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc(this._repository) : super(const VerificationState()) {
    on<FetchPendingVerifications>(_onFetch);
    on<ApproveBusiness>(_onApprove);
    on<RejectBusiness>(_onReject);
  }

  final VerificationRepository _repository;

  Future<void> _onFetch(
    FetchPendingVerifications event,
    Emitter<VerificationState> emit,
  ) async {
    emit(state.copyWith(loadStatus: VerificationLoadStatus.loading));
    try {
      final requests = await _repository.fetchPendingVerifications();
      emit(state.copyWith(loadStatus: VerificationLoadStatus.success, requests: requests));
    } catch (_) {
      emit(state.copyWith(loadStatus: VerificationLoadStatus.failure));
    }
  }

  Future<void> _onApprove(
    ApproveBusiness event,
    Emitter<VerificationState> emit,
  ) => _process(event.verificationId, emit, () => _repository.approveBusiness(event.verificationId));

  Future<void> _onReject(
    RejectBusiness event,
    Emitter<VerificationState> emit,
  ) => _process(event.verificationId, emit, () => _repository.rejectBusiness(event.verificationId, event.reason));

  Future<void> _process(
    String id,
    Emitter<VerificationState> emit,
    Future<void> Function() action,
  ) async {
    emit(state.copyWith(actionStatus: VerificationActionStatus.loading, processingId: id));
    try {
      await action();
      emit(state.copyWith(
        actionStatus: VerificationActionStatus.success,
        requests: state.requests.where((request) => request.id != id).toList(growable: false),
        clearProcessingId: true,
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: VerificationActionStatus.failure, clearProcessingId: true));
    }
  }
}
