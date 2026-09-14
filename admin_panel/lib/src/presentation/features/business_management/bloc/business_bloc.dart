import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/business_details.dart';
import '../../../../domain/repositories/business_repository.dart';
import 'business_event.dart';
import 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  BusinessBloc(this._repository) : super(const BusinessState()) {
    on<FetchBusinesses>(_onFetchBusinesses);
    on<SearchBusinesses>(_onSearchBusinesses);
    on<FilterBusinesses>(_onFilterBusinesses);
    on<UpdateBusiness>(_onUpdateBusiness);
  }

  final BusinessRepository _repository;

  Future<void> _onFetchBusinesses(
    FetchBusinesses event,
    Emitter<BusinessState> emit,
  ) async {
    emit(state.copyWith(loadStatus: BusinessLoadStatus.loading));
    try {
      final businesses = await _repository.fetchBusinesses();
      emit(state.copyWith(
        loadStatus: BusinessLoadStatus.success,
        businesses: _filterByStatus(businesses, state.status),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: BusinessLoadStatus.failure));
    }
  }

  Future<void> _onSearchBusinesses(
    SearchBusinesses event,
    Emitter<BusinessState> emit,
  ) async {
    emit(state.copyWith(
      loadStatus: BusinessLoadStatus.loading,
      searchQuery: event.query,
    ));
    try {
      final businesses = await _repository.searchBusinesses(event.query);
      emit(state.copyWith(
        loadStatus: BusinessLoadStatus.success,
        businesses: _filterByStatus(businesses, state.status),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: BusinessLoadStatus.failure));
    }
  }

  Future<void> _onFilterBusinesses(
    FilterBusinesses event,
    Emitter<BusinessState> emit,
  ) async {
    emit(state.copyWith(
      loadStatus: BusinessLoadStatus.loading,
      status: event.status,
      clearStatus: event.status == null,
    ));
    try {
      final businesses = await _repository.searchBusinesses(state.searchQuery);
      emit(state.copyWith(
        loadStatus: BusinessLoadStatus.success,
        businesses: _filterByStatus(businesses, event.status),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: BusinessLoadStatus.failure));
    }
  }

  Future<void> _onUpdateBusiness(
    UpdateBusiness event,
    Emitter<BusinessState> emit,
  ) async {
    emit(state.copyWith(updateStatus: BusinessUpdateStatus.loading));
    try {
      await _repository.updateBusiness(event.details);
      final businesses = state.businesses
          .map((business) =>
              business.id == event.details.id ? event.details : business)
          .where((business) =>
              state.status == null || business.status == state.status)
          .toList(growable: false);
      emit(state.copyWith(
        businesses: businesses,
        updateStatus: BusinessUpdateStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(updateStatus: BusinessUpdateStatus.failure));
    }
  }

  List<BusinessDetails> _filterByStatus(
    List<BusinessDetails> businesses,
    BusinessStatus? status,
  ) =>
      status == null
          ? businesses
          : businesses.where((business) => business.status == status).toList();
}
