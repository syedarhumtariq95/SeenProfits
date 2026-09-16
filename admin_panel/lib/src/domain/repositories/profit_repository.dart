import '../models/profit_distribution_model.dart';

abstract class ProfitRepository {
  Future<List<ProfitDistributionModel>> fetchProfitDistributions();

  Future<ProfitDistributionModel> triggerProfitDistribution(
    String distributionId,
  );

  Future<ProfitDistributionModel> updatePayoutStatus(
    String distributionId,
    PayoutStatus status,
  );
}
