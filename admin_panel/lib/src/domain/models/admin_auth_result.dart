enum AdminAuthResultType { awaitingTwoFactor, authenticated, failure }

enum AdminAuthFailure { invalidCredentials, invalidVerificationCode }

class AdminAuthResult {
  const AdminAuthResult._({required this.type, this.failure});

  const AdminAuthResult.awaitingTwoFactor()
      : this._(type: AdminAuthResultType.awaitingTwoFactor);

  const AdminAuthResult.authenticated()
      : this._(type: AdminAuthResultType.authenticated);

  const AdminAuthResult.failure(AdminAuthFailure failure)
      : this._(type: AdminAuthResultType.failure, failure: failure);

  final AdminAuthResultType type;
  final AdminAuthFailure? failure;
}
