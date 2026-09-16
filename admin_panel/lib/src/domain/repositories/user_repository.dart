import '../models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> fetchUsers();

  Future<List<UserModel>> searchUsers(String query);

  Future<UserModel> toggleUserStatus(UserModel user);
}
