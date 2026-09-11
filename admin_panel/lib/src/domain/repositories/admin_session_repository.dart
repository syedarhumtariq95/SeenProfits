import '../../core/permissions/admin_permissions.dart';
import '../models/admin_auth_result.dart';

/// Contract placeholder for a future authenticated admin-session source.
/// No implementation or persistence is introduced in the foundation phase.
abstract interface class AdminSessionRepository {
  Future<AdminRole?> getCurrentRole();

  Future<AdminAuthResult> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<AdminAuthResult> verifyTwoFactorCode(String code);

  Future<void> resendTwoFactorCode();

  Future<void> cancelTwoFactorChallenge();

  Future<void> requestPasswordReset(String email);

  Future<void> logout();
}
