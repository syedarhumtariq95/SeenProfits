import '../models/verification_request.dart';

abstract class VerificationRepository {
  Future<List<VerificationRequest>> fetchPendingVerifications();

  Future<void> approveBusiness(String verificationId);

  Future<void> rejectBusiness(String verificationId, String reason);
}
