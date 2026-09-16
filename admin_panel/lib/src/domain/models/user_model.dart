enum UserRole { investor, businessOwner }

enum UserStatus { active, suspended }

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.joinedDate,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final UserStatus status;
  final DateTime joinedDate;

  UserModel copyWith({UserStatus? status}) => UserModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        role: role,
        status: status ?? this.status,
        joinedDate: joinedDate,
      );
}
