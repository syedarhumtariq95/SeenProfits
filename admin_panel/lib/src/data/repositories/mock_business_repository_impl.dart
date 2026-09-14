import '../../domain/models/business_details.dart';
import '../../domain/repositories/business_repository.dart';

/// In-memory repository that behaves like a remote business-management API.
class MockBusinessRepositoryImpl implements BusinessRepository {
  MockBusinessRepositoryImpl(
      {this.networkLatency = const Duration(milliseconds: 650)});

  /// Deliberate delay for exercising loading, search, and update UI states.
  final Duration networkLatency;

  final Map<String, BusinessDetails> _businesses = {
    'alpha': const BusinessDetails(
      id: 'alpha',
      name: 'Alpha Foods',
      owner: 'Ayesha Khan',
      category: BusinessCategory.foodAndBeverage,
      email: 'alpha@seenprofits.com',
      status: BusinessStatus.active,
      tier: 'growth',
    ),
    'vertex': const BusinessDetails(
      id: 'vertex',
      name: 'Vertex Labs',
      owner: 'Bilal Ahmed',
      category: BusinessCategory.technology,
      email: 'vertex@seenprofits.com',
      status: BusinessStatus.suspended,
      tier: 'enterprise',
    ),
    'greenfield': const BusinessDetails(
      id: 'greenfield',
      name: 'Greenfield Farms',
      owner: 'Fatima Ali',
      category: BusinessCategory.agriculture,
      email: 'greenfield@seenprofits.com',
      status: BusinessStatus.pending,
      tier: 'starter',
    ),
    'atlas': const BusinessDetails(
      id: 'atlas',
      name: 'Atlas Manufacturing',
      owner: 'Hamza Raza',
      category: BusinessCategory.manufacturing,
      email: 'atlas@seenprofits.com',
      status: BusinessStatus.active,
      tier: 'growth',
    ),
  };

  @override
  Future<List<BusinessDetails>> fetchBusinesses() async {
    await _simulateNetworkRequest();
    return _businesses.values.toList(growable: false);
  }

  @override
  Future<List<BusinessDetails>> searchBusinesses(String query) async {
    await _simulateNetworkRequest();
    final normalizedQuery = query.trim().toLowerCase();
    return _businesses.values
        .where((business) =>
            normalizedQuery.isEmpty ||
            business.name.toLowerCase().contains(normalizedQuery) ||
            business.owner.toLowerCase().contains(normalizedQuery) ||
            business.email.toLowerCase().contains(normalizedQuery))
        .toList(growable: false);
  }

  @override
  Future<void> updateBusiness(BusinessDetails details) async {
    await _simulateNetworkRequest();
    _businesses[details.id] = details;
  }

  Future<void> _simulateNetworkRequest() =>
      Future<void>.delayed(networkLatency);
}
