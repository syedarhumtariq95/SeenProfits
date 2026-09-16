import '../../../../domain/models/verification_request.dart';

enum VerificationLoadStatus { initial, loading, success, failure }

enum VerificationActionStatus { idle, loading, success, failure }

class VerificationState {
  const VerificationState({
    this.loadStatus = VerificationLoadStatus.initial,
    this.actionStatus = VerificationActionStatus.idle,
    this.requests = const [],
    this.processingId,
  });

  final VerificationLoadStatus loadStatus;
  final VerificationActionStatus actionStatus;
  final List<VerificationRequest> requests;
  final String? processingId;

  VerificationState copyWith({
    VerificationLoadStatus? loadStatus,
    VerificationActionStatus? actionStatus,
    List<VerificationRequest>? requests,
    String? processingId,
    bool clearProcessingId = false,
  }) =>
      VerificationState(
        loadStatus: loadStatus ?? this.loadStatus,
        actionStatus: actionStatus ?? this.actionStatus,
        requests: requests ?? this.requests,
        processingId:
            clearProcessingId ? null : processingId ?? this.processingId,
      );
}
