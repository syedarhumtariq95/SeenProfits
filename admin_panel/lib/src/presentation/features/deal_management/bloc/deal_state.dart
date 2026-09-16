import '../../../../domain/models/deal_model.dart';

enum DealLoadStatus { initial, loading, success, failure }

enum DealActionStatus { idle, loading, success, failure }

class DealState {
  const DealState({
    this.loadStatus = DealLoadStatus.initial,
    this.actionStatus = DealActionStatus.idle,
    this.deals = const [],
    this.query = '',
    this.statusFilter,
    this.processingId,
  });

  final DealLoadStatus loadStatus;
  final DealActionStatus actionStatus;
  final List<DealModel> deals;
  final String query;
  final DealStatus? statusFilter;
  final String? processingId;

  List<DealModel> get visibleDeals {
    final normalized = query.trim().toLowerCase();
    return deals.where((deal) {
      final matchesQuery = normalized.isEmpty ||
          deal.businessName.toLowerCase().contains(normalized) ||
          deal.investorName.toLowerCase().contains(normalized);
      return matchesQuery &&
          (statusFilter == null || deal.status == statusFilter);
    }).toList(growable: false);
  }

  DealState copyWith({
    DealLoadStatus? loadStatus,
    DealActionStatus? actionStatus,
    List<DealModel>? deals,
    String? query,
    DealStatus? statusFilter,
    bool clearStatusFilter = false,
    String? processingId,
    bool clearProcessingId = false,
  }) =>
      DealState(
        loadStatus: loadStatus ?? this.loadStatus,
        actionStatus: actionStatus ?? this.actionStatus,
        deals: deals ?? this.deals,
        query: query ?? this.query,
        statusFilter:
            clearStatusFilter ? null : statusFilter ?? this.statusFilter,
        processingId:
            clearProcessingId ? null : processingId ?? this.processingId,
      );
}
