import '../../../../domain/models/profit_distribution_model.dart';

sealed class ProfitEvent {
  const ProfitEvent();
}

class FetchProfitDistributions extends ProfitEvent {
  const FetchProfitDistributions();
}

class FilterProfitByStatus extends ProfitEvent {
  const FilterProfitByStatus(this.status);
  final PayoutStatus? status;
}

class SearchProfitDistributions extends ProfitEvent {
  const SearchProfitDistributions(this.query);
  final String query;
}

class TriggerProfitDistribution extends ProfitEvent {
  const TriggerProfitDistribution(this.distributionId);
  final String distributionId;
}

class UpdateProfitPayout extends ProfitEvent {
  const UpdateProfitPayout(this.distributionId, this.status);
  final String distributionId;
  final PayoutStatus status;
}
