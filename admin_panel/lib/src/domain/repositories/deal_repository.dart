import '../models/deal_model.dart';

abstract class DealRepository {
  Future<List<DealModel>> fetchDeals();
  Future<void> approveProposal(String dealId);
  Future<void> rejectProposal(String dealId);
  Future<void> updateStatus(String dealId, DealStatus status);
}
