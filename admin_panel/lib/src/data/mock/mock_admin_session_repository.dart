import '../../core/auth/admin_session.dart';
import '../../core/permissions/admin_permissions.dart';
import '../../domain/models/admin_auth_result.dart';
import '../../domain/repositories/admin_session_repository.dart';

/// Development-only implementation. It makes no network or storage calls.
/// Demo login: admin@demo.local / DemoAdmin123!
/// Demo 2FA code: 123456
class MockAdminSessionRepository implements AdminSessionRepository {
  MockAdminSessionRepository(this._session);

  static const _demoEmail = 'admin@demo.local';
  static const _demoPassword = 'DemoAdmin123!';
  static const _demoTwoFactorCode = '123456';

  final AdminSession _session;

  @override
  Future<AdminRole?> getCurrentRole() async => _session.role;

  @override
  Future<AdminAuthResult> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (email.trim().toLowerCase() != _demoEmail || password != _demoPassword) {
      return const AdminAuthResult.failure(AdminAuthFailure.invalidCredentials);
    }

    // `rememberMe` is accepted only to preserve the future API contract. This
    // mock session remains in memory for the current browser runtime only.
    _session.beginTwoFactorChallenge(AdminRole.superAdmin);
    return const AdminAuthResult.awaitingTwoFactor();
  }

  @override
  Future<AdminAuthResult> verifyTwoFactorCode(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (code != _demoTwoFactorCode || !_session.completeTwoFactorChallenge()) {
      return const AdminAuthResult.failure(
        AdminAuthFailure.invalidVerificationCode,
      );
    }
    return const AdminAuthResult.authenticated();
  }

  @override
  Future<void> resendTwoFactorCode() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  @override
  Future<void> cancelTwoFactorChallenge() async {
    _session.cancelTwoFactorChallenge();
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  @override
  Future<void> logout() async => _session.clear();
}
