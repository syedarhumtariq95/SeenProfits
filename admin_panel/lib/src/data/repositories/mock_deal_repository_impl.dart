import '../../domain/models/deal_model.dart';
import '../../domain/repositories/deal_repository.dart';

class MockDealRepositoryImpl implements DealRepository {
  MockDealRepositoryImpl(
      {this.networkLatency = const Duration(milliseconds: 450)})
      : _deals = {
          'deal-1': DealModel(
            id: 'deal-1',
            businessName: 'Alpha Foods',
            investorName: 'Ayesha Khan',
            amount: 250000,
            expectedReturn: 18,
            submittedAt: DateTime(2026, 9, 12),
            status: DealStatus.pending,
            notes: 'Expansion of cold-chain delivery operations.',
          ),
          'deal-2': DealModel(
            id: 'deal-2',
            businessName: 'Vertex Solutions',
            investorName: 'Bilal Ahmed',
            amount: 500000,
            expectedReturn: 22,
            submittedAt: DateTime(2026, 9, 10),
            status: DealStatus.approved,
          ),
          'deal-3': DealModel(
            id: 'deal-3',
            businessName: 'Greenfield Farms',
            investorName: 'Fatima Noor',
            amount: 175000,
            expectedReturn: 15,
            submittedAt: DateTime(2026, 9, 7),
            status: DealStatus.active,
          ),
          'deal-4': DealModel(
            id: 'deal-4',
            businessName: 'Atlas Textiles',
            investorName: 'Hamza Ali',
            amount: 320000,
            expectedReturn: 20,
            submittedAt: DateTime(2026, 8, 29),
            status: DealStatus.rejected,
          ),
          'deal-5': DealModel(
            id: 'deal-5',
            businessName: 'Karachi Crafts',
            investorName: 'Ayesha Khan',
            amount: 120000,
            expectedReturn: 12,
            submittedAt: DateTime(2026, 7, 15),
            status: DealStatus.completed,
          ),
        };

  final Duration networkLatency;
  final Map<String, DealModel> _deals;

  @override
  Future<List<DealModel>> fetchDeals() async {
    await _delay();
    return List.unmodifiable(_deals.values);
  }

  @override
  Future<void> approveProposal(String dealId) =>
      updateStatus(dealId, DealStatus.approved);

  @override
  Future<void> rejectProposal(String dealId) =>
      updateStatus(dealId, DealStatus.rejected);

  @override
  Future<void> updateStatus(String dealId, DealStatus status) async {
    await _delay();
    final deal = _deals[dealId];
    if (deal == null) throw StateError('Deal not found.');
    _deals[dealId] = deal.copyWith(status: status);
  }

  Future<void> _delay() => Future<void>.delayed(networkLatency);
}
