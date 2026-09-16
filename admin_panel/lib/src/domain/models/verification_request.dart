enum VerificationStatus { pending, approved, rejected }

class VerificationRequest {
  const VerificationRequest({
    required this.id,
    required this.businessName,
    required this.cnic,
    required this.documents,
    required this.status,
    this.rejectionReason,
  });

  final String id;
  final String businessName;
  final String cnic;
  final List<String> documents;
  final VerificationStatus status;
  final String? rejectionReason;

  VerificationRequest copyWith({
    VerificationStatus? status,
    String? rejectionReason,
    bool clearRejectionReason = false,
  }) =>
      VerificationRequest(
        id: id,
        businessName: businessName,
        cnic: cnic,
        documents: documents,
        status: status ?? this.status,
        rejectionReason: clearRejectionReason
            ? null
            : rejectionReason ?? this.rejectionReason,
      );
}
