import '../../../../domain/models/user_model.dart';

sealed class UserEvent {
  const UserEvent();
}

class FetchUsers extends UserEvent {
  const FetchUsers();
}

class SearchUsers extends UserEvent {
  const SearchUsers(this.query);
  final String query;
}

class FilterUsersByRole extends UserEvent {
  const FilterUsersByRole(this.role);
  final UserRole? role;
}

class ToggleUserStatus extends UserEvent {
  const ToggleUserStatus(this.user);
  final UserModel user;
}
