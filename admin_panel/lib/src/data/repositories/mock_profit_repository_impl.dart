import '../../domain/models/profit_distribution_model.dart';
import '../../domain/repositories/profit_repository.dart';

class MockProfitRepositoryImpl implements ProfitRepository {
  final List<ProfitDistributionModel> _distributions = [
    ProfitDistributionModel(
      id: 'dist-001',
      businessId: 'biz-alpha',
      investorId: 'inv-sana',
      businessName: 'Alpha Foods',
      investorName: 'Sana Malik',
      totalProfit: 142000,
      investorYield: 42600,
      distributionDate: DateTime(2026, 9, 14),
      status: PayoutStatus.pending,
    ),
    ProfitDistributionModel(
      id: 'dist-002',
      businessId: 'biz-vertex',
      investorId: 'inv-omar',
      businessName: 'Vertex Solutions',
      investorName: 'Omar Farooq',
      totalProfit: 218500,
      investorYield: 65550,
      distributionDate: DateTime(2026, 9, 10),
      status: PayoutStatus.processing,
    ),
    ProfitDistributionModel(
      id: 'dist-003',
      businessId: 'biz-greenfield',
      investorId: 'inv-hira',
      businessName: 'Greenfield Farms',
      investorName: 'Hira Shah',
      totalProfit: 98500,
      investorYield: 29550,
      distributionDate: DateTime(2026, 8, 29),
      status: PayoutStatus.paid,
    ),
    ProfitDistributionModel(
      id: 'dist-004',
      businessId: 'biz-atlas',
      investorId: 'inv-ayesha',
      businessName: 'Atlas Textiles',
      investorName: 'Ayesha Khan',
      totalProfit: 76000,
      investorYield: 22800,
      distributionDate: DateTime(2026, 8, 22),
      status: PayoutStatus.failed,
    ),
  ];

  @override
  Future<List<ProfitDistributionModel>> fetchProfitDistributions() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return List.unmodifiable(_distributions);
  }

  @override
  Future<ProfitDistributionModel> triggerProfitDistribution(
    String distributionId,
  ) =>
      _update(distributionId, PayoutStatus.processing);

  @override
  Future<ProfitDistributionModel> updatePayoutStatus(
    String distributionId,
    PayoutStatus status,
  ) =>
      _update(distributionId, status);

  Future<ProfitDistributionModel> _update(
    String id,
    PayoutStatus status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final index = _distributions.indexWhere((item) => item.id == id);
    if (index < 0) throw StateError('Distribution not found');
    final updated = _distributions[index].copyWith(status: status);
    _distributions[index] = updated;
    return updated;
  }
}
