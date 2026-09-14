import '../models/business_details.dart';

abstract class BusinessRepository {
  Future<List<BusinessDetails>> fetchBusinesses();

  Future<List<BusinessDetails>> searchBusinesses(String query);

  Future<void> updateBusiness(BusinessDetails details);
}
