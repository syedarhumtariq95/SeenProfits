sealed class VerificationEvent {
  const VerificationEvent();
}

class FetchPendingVerifications extends VerificationEvent {
  const FetchPendingVerifications();
}

class ApproveBusiness extends VerificationEvent {
  const ApproveBusiness(this.verificationId);

  final String verificationId;
}

class RejectBusiness extends VerificationEvent {
  const RejectBusiness(this.verificationId, this.reason);

  final String verificationId;
  final String reason;
}
