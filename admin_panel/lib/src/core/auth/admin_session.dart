// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../permissions/admin_permissions.dart';

/// In-memory session state for the development-only mock authentication flow.
/// It stores only the selected mock role in browser local storage so protected
/// routes survive a refresh during development. It has no token or production
/// security logic and must be replaced by a real authenticated session.
class AdminSession {
  AdminSession() {
    _role = _roleFromName(html.window.localStorage[_mockRoleStorageKey]);
  }

  static const _mockRoleStorageKey = 'seen_profits_admin_mock_role';

  AdminRole? _role;
  AdminRole? _pendingRole;

  bool get isAuthenticated => _role != null;

  bool get isAwaitingTwoFactor => _pendingRole != null;

  AdminRole? get role => _role;

  void beginTwoFactorChallenge(AdminRole role) {
    _role = null;
    _pendingRole = role;
  }

  bool completeTwoFactorChallenge() {
    final pendingRole = _pendingRole;
    if (pendingRole == null) {
      return false;
    }
    _role = pendingRole;
    _pendingRole = null;
    html.window.localStorage[_mockRoleStorageKey] = pendingRole.name;
    return true;
  }

  void cancelTwoFactorChallenge() => _pendingRole = null;

  void clear() {
    _role = null;
    _pendingRole = null;
    html.window.localStorage.remove(_mockRoleStorageKey);
  }

  AdminRole? _roleFromName(String? value) {
    for (final role in AdminRole.values) {
      if (role.name == value) {
        return role;
      }
    }
    return null;
  }

  bool can(AdminPermission permission) =>
      _role?.permissions.contains(permission) ?? false;
}
