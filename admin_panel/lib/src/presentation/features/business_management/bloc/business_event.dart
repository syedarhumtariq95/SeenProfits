import '../../../../domain/models/business_details.dart';

sealed class BusinessEvent {
  const BusinessEvent();
}

class FetchBusinesses extends BusinessEvent {
  const FetchBusinesses();
}

class SearchBusinesses extends BusinessEvent {
  const SearchBusinesses(this.query);

  final String query;
}

class FilterBusinesses extends BusinessEvent {
  const FilterBusinesses(this.status);

  final BusinessStatus? status;
}

class UpdateBusiness extends BusinessEvent {
  const UpdateBusiness(this.details);

  final BusinessDetails details;
}
