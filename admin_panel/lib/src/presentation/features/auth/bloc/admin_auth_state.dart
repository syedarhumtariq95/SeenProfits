import '../../../../domain/models/admin_auth_result.dart';

enum AdminAuthStatus {
  initial,
  loading,
  awaitingTwoFactor,
  authenticated,
  passwordResetSent,
  failure,
}

class AdminAuthState {
  const AdminAuthState({
    this.status = AdminAuthStatus.initial,
    this.failure,
  });

  final AdminAuthStatus status;
  final AdminAuthFailure? failure;

  AdminAuthState copyWith({
    AdminAuthStatus? status,
    AdminAuthFailure? failure,
    bool clearFailure = false,
  }) {
    return AdminAuthState(
      status: status ?? this.status,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
