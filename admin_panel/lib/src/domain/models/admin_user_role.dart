import '../../core/permissions/admin_permissions.dart';

/// Domain-level role value retained separately from UI navigation so future
/// admin account repositories can map backend role identifiers safely.
class AdminUserRole {
  const AdminUserRole(this.value);

  final AdminRole value;
}
