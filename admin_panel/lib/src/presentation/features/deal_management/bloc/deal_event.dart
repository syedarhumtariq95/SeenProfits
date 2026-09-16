import '../../../../domain/models/deal_model.dart';

sealed class DealEvent {
  const DealEvent();
}

class FetchDeals extends DealEvent {
  const FetchDeals();
}

class SearchDeals extends DealEvent {
  const SearchDeals(this.query);
  final String query;
}

class FilterDealsByStatus extends DealEvent {
  const FilterDealsByStatus(this.status);
  final DealStatus? status;
}

class ApproveProposal extends DealEvent {
  const ApproveProposal(this.dealId);
  final String dealId;
}

class RejectProposal extends DealEvent {
  const RejectProposal(this.dealId);
  final String dealId;
}
