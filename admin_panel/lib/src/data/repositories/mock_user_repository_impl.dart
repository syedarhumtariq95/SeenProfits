import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class MockUserRepositoryImpl implements UserRepository {
  MockUserRepositoryImpl(
      {this.networkLatency = const Duration(milliseconds: 650)});

  final Duration networkLatency;

  final Map<String, UserModel> _users = {
    'investor-1': UserModel(
      id: 'investor-1',
      name: 'Sana Malik',
      email: 'sana@seenprofits.com',
      phone: '+92 300 1112233',
      role: UserRole.investor,
      status: UserStatus.active,
      joinedDate: DateTime(2026, 1, 12),
    ),
    'investor-2': UserModel(
      id: 'investor-2',
      name: 'Omar Farooq',
      email: 'omar@seenprofits.com',
      phone: '+92 301 2223344',
      role: UserRole.investor,
      status: UserStatus.suspended,
      joinedDate: DateTime(2026, 2, 3),
    ),
    'investor-3': UserModel(
      id: 'investor-3',
      name: 'Hira Shah',
      email: 'hira@seenprofits.com',
      phone: '+92 302 3334455',
      role: UserRole.investor,
      status: UserStatus.active,
      joinedDate: DateTime(2026, 3, 18),
    ),
    'owner-1': UserModel(
      id: 'owner-1',
      name: 'Ayesha Khan',
      email: 'ayesha@seenprofits.com',
      phone: '+92 303 4445566',
      role: UserRole.businessOwner,
      status: UserStatus.active,
      joinedDate: DateTime(2025, 11, 21),
    ),
    'owner-2': UserModel(
      id: 'owner-2',
      name: 'Bilal Ahmed',
      email: 'bilal@seenprofits.com',
      phone: '+92 304 5556677',
      role: UserRole.businessOwner,
      status: UserStatus.suspended,
      joinedDate: DateTime(2026, 1, 30),
    ),
    'owner-3': UserModel(
      id: 'owner-3',
      name: 'Fatima Noor',
      email: 'fatima@seenprofits.com',
      phone: '+92 305 6667788',
      role: UserRole.businessOwner,
      status: UserStatus.active,
      joinedDate: DateTime(2026, 4, 5),
    ),
  };

  @override
  Future<List<UserModel>> fetchUsers() async {
    await _simulateNetworkRequest();
    return _users.values.toList(growable: false);
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    await _simulateNetworkRequest();
    final normalized = query.trim().toLowerCase();
    return _users.values
        .where((user) =>
            normalized.isEmpty ||
            user.name.toLowerCase().contains(normalized) ||
            user.email.toLowerCase().contains(normalized) ||
            user.phone.toLowerCase().contains(normalized))
        .toList(growable: false);
  }

  @override
  Future<UserModel> toggleUserStatus(UserModel user) async {
    await _simulateNetworkRequest();
    final updated = user.copyWith(
      status: user.status == UserStatus.active
          ? UserStatus.suspended
          : UserStatus.active,
    );
    _users[user.id] = updated;
    return updated;
  }

  Future<void> _simulateNetworkRequest() =>
      Future<void>.delayed(networkLatency);
}
