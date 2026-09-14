import '../../domain/models/verification_request.dart';
import '../../domain/repositories/verification_repository.dart';

class MockVerificationRepositoryImpl implements VerificationRepository {
  MockVerificationRepositoryImpl({
    this.networkLatency = const Duration(milliseconds: 500),
  });

  final Duration networkLatency;
  final Map<String, VerificationRequest> _requests = {
    'verification-1': const VerificationRequest(
      id: 'verification-1',
      businessName: 'Karachi Crafts',
      cnic: '35202-1234567-1',
      documents: ['CNIC front', 'Business registration'],
      status: VerificationStatus.pending,
    ),
    'verification-2': const VerificationRequest(
      id: 'verification-2',
      businessName: 'North Star Technologies',
      cnic: '42101-7654321-9',
      documents: ['CNIC front', 'Proof of address'],
      status: VerificationStatus.pending,
    ),
  };

  @override
  Future<List<VerificationRequest>> fetchPendingVerifications() async {
    await _delay();
    return _requests.values
        .where((request) => request.status == VerificationStatus.pending)
        .toList(growable: false);
  }

  @override
  Future<void> approveBusiness(String verificationId) async {
    await _delay();
    final request = _requestFor(verificationId);
    _requests[verificationId] = request.copyWith(
      status: VerificationStatus.approved,
      clearRejectionReason: true,
    );
  }

  @override
  Future<void> rejectBusiness(String verificationId, String reason) async {
    await _delay();
    final request = _requestFor(verificationId);
    _requests[verificationId] = request.copyWith(
      status: VerificationStatus.rejected,
      rejectionReason: reason,
    );
  }

  VerificationRequest _requestFor(String id) {
    final request = _requests[id];
    if (request == null) throw StateError('Verification request not found.');
    return request;
  }

  Future<void> _delay() => Future<void>.delayed(networkLatency);
}
