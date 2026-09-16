import '../../../../domain/models/profit_distribution_model.dart';

enum ProfitLoadStatus { initial, loading, success, failure }

enum ProfitActionStatus { idle, loading, success, failure }

class ProfitState {
  const ProfitState({
    this.loadStatus = ProfitLoadStatus.initial,
    this.actionStatus = ProfitActionStatus.idle,
    this.distributions = const [],
    this.statusFilter,
    this.searchQuery = '',
    this.processingId,
  });

  final ProfitLoadStatus loadStatus;
  final ProfitActionStatus actionStatus;
  final List<ProfitDistributionModel> distributions;
  final PayoutStatus? statusFilter;
  final String searchQuery;
  final String? processingId;

  List<ProfitDistributionModel> get visibleDistributions => distributions
          .where((item) => statusFilter == null || item.status == statusFilter)
          .where((item) {
        final query = searchQuery.trim().toLowerCase();
        return query.isEmpty ||
            item.businessName.toLowerCase().contains(query) ||
            item.investorName.toLowerCase().contains(query);
      }).toList(growable: false);

  ProfitState copyWith({
    ProfitLoadStatus? loadStatus,
    ProfitActionStatus? actionStatus,
    List<ProfitDistributionModel>? distributions,
    PayoutStatus? statusFilter,
    String? searchQuery,
    String? processingId,
    bool clearStatusFilter = false,
    bool clearProcessingId = false,
  }) =>
      ProfitState(
        loadStatus: loadStatus ?? this.loadStatus,
        actionStatus: actionStatus ?? this.actionStatus,
        distributions: distributions ?? this.distributions,
        statusFilter:
            clearStatusFilter ? null : statusFilter ?? this.statusFilter,
        searchQuery: searchQuery ?? this.searchQuery,
        processingId:
            clearProcessingId ? null : processingId ?? this.processingId,
      );
}
