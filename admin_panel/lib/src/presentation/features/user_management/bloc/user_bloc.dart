import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user_model.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(const UserState()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
    on<FilterUsersByRole>(_onFilterUsersByRole);
    on<ToggleUserStatus>(_onToggleUserStatus);
  }

  final UserRepository _repository;

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    await _load(emit, () => _repository.fetchUsers());
  }

  Future<void> _onSearchUsers(
      SearchUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(
        loadStatus: UserLoadStatus.loading, searchQuery: event.query));
    await _load(emit, () => _repository.searchUsers(event.query));
  }

  Future<void> _onFilterUsersByRole(
      FilterUsersByRole event, Emitter<UserState> emit) async {
    emit(state.copyWith(
      loadStatus: UserLoadStatus.loading,
      role: event.role,
      clearRole: event.role == null,
    ));
    await _load(emit, () => _repository.searchUsers(state.searchQuery));
  }

  Future<void> _onToggleUserStatus(
      ToggleUserStatus event, Emitter<UserState> emit) async {
    emit(state.copyWith(updateStatus: UserUpdateStatus.loading));
    try {
      final updated = await _repository.toggleUserStatus(event.user);
      final users = state.users
          .map((user) => user.id == updated.id ? updated : user)
          .toList(growable: false);
      emit(
          state.copyWith(users: users, updateStatus: UserUpdateStatus.success));
    } catch (_) {
      emit(state.copyWith(updateStatus: UserUpdateStatus.failure));
    }
  }

  Future<void> _load(
      Emitter<UserState> emit, Future<List<UserModel>> Function() load) async {
    try {
      final users = await load();
      emit(state.copyWith(
        loadStatus: UserLoadStatus.success,
        users: state.role == null
            ? users
            : users
                .where((user) => user.role == state.role)
                .toList(growable: false),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: UserLoadStatus.failure));
    }
  }
}
