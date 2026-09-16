import '../../../../domain/models/user_model.dart';

enum UserLoadStatus { initial, loading, success, failure }

enum UserUpdateStatus { idle, loading, success, failure }

class UserState {
  const UserState({
    this.loadStatus = UserLoadStatus.initial,
    this.updateStatus = UserUpdateStatus.idle,
    this.users = const [],
    this.searchQuery = '',
    this.role,
  });

  final UserLoadStatus loadStatus;
  final UserUpdateStatus updateStatus;
  final List<UserModel> users;
  final String searchQuery;
  final UserRole? role;

  UserState copyWith({
    UserLoadStatus? loadStatus,
    UserUpdateStatus? updateStatus,
    List<UserModel>? users,
    String? searchQuery,
    UserRole? role,
    bool clearRole = false,
  }) =>
      UserState(
        loadStatus: loadStatus ?? this.loadStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        users: users ?? this.users,
        searchQuery: searchQuery ?? this.searchQuery,
        role: clearRole ? null : role ?? this.role,
      );
}
