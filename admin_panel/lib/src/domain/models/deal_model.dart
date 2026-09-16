enum DealStatus { pending, approved, rejected, active, completed }

class DealModel {
  const DealModel({
    required this.id,
    required this.businessName,
    required this.investorName,
    required this.amount,
    required this.expectedReturn,
    required this.submittedAt,
    required this.status,
    this.notes,
  });

  final String id;
  final String businessName;
  final String investorName;
  final double amount;
  final double expectedReturn;
  final DateTime submittedAt;
  final DealStatus status;
  final String? notes;

  DealModel copyWith({DealStatus? status}) => DealModel(
        id: id,
        businessName: businessName,
        investorName: investorName,
        amount: amount,
        expectedReturn: expectedReturn,
        submittedAt: submittedAt,
        status: status ?? this.status,
        notes: notes,
      );
}
