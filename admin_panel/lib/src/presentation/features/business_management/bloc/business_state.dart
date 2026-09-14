import '../../../../domain/models/business_details.dart';

enum BusinessLoadStatus { initial, loading, success, failure }

enum BusinessUpdateStatus { idle, loading, success, failure }

class BusinessState {
  const BusinessState({
    this.loadStatus = BusinessLoadStatus.initial,
    this.updateStatus = BusinessUpdateStatus.idle,
    this.businesses = const [],
    this.searchQuery = '',
    this.status,
  });

  final BusinessLoadStatus loadStatus;
  final BusinessUpdateStatus updateStatus;
  final List<BusinessDetails> businesses;
  final String searchQuery;
  final BusinessStatus? status;

  BusinessState copyWith({
    BusinessLoadStatus? loadStatus,
    BusinessUpdateStatus? updateStatus,
    List<BusinessDetails>? businesses,
    String? searchQuery,
    BusinessStatus? status,
    bool clearStatus = false,
  }) =>
      BusinessState(
        loadStatus: loadStatus ?? this.loadStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        businesses: businesses ?? this.businesses,
        searchQuery: searchQuery ?? this.searchQuery,
        status: clearStatus ? null : status ?? this.status,
      );
}
