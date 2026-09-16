enum PayoutStatus { pending, processing, paid, failed }

class ProfitDistributionModel {
  const ProfitDistributionModel({
    required this.id,
    required this.businessId,
    required this.investorId,
    required this.businessName,
    required this.investorName,
    required this.totalProfit,
    required this.investorYield,
    required this.distributionDate,
    required this.status,
  });

  final String id;
  final String businessId;
  final String investorId;
  final String businessName;
  final String investorName;
  final double totalProfit;
  final double investorYield;
  final DateTime distributionDate;
  final PayoutStatus status;

  ProfitDistributionModel copyWith({PayoutStatus? status}) =>
      ProfitDistributionModel(
        id: id,
        businessId: businessId,
        investorId: investorId,
        businessName: businessName,
        investorName: investorName,
        totalProfit: totalProfit,
        investorYield: investorYield,
        distributionDate: distributionDate,
        status: status ?? this.status,
      );
}
