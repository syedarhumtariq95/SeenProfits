import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/admin_auth_result.dart';
import '../../../../domain/repositories/admin_session_repository.dart';
import 'admin_auth_state.dart';

class AdminAuthCubit extends Cubit<AdminAuthState> {
  AdminAuthCubit(this._repository) : super(const AdminAuthState());

  final AdminSessionRepository _repository;

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(const AdminAuthState(status: AdminAuthStatus.loading));
    final result = await _repository.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    _emitResult(result);
  }

  Future<void> verifyTwoFactorCode(String code) async {
    emit(const AdminAuthState(status: AdminAuthStatus.loading));
    final result = await _repository.verifyTwoFactorCode(code);
    _emitResult(result);
  }

  Future<void> requestPasswordReset(String email) async {
    emit(const AdminAuthState(status: AdminAuthStatus.loading));
    await _repository.requestPasswordReset(email);
    emit(const AdminAuthState(status: AdminAuthStatus.passwordResetSent));
  }

  Future<void> cancelTwoFactorChallenge() async {
    await _repository.cancelTwoFactorChallenge();
    emit(const AdminAuthState());
  }

  Future<void> resendTwoFactorCode() async {
    emit(const AdminAuthState(status: AdminAuthStatus.loading));
    await _repository.resendTwoFactorCode();
    emit(const AdminAuthState(status: AdminAuthStatus.awaitingTwoFactor));
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(const AdminAuthState());
  }

  void clearFeedback() => emit(const AdminAuthState());

  void _emitResult(AdminAuthResult result) {
    switch (result.type) {
      case AdminAuthResultType.awaitingTwoFactor:
        emit(const AdminAuthState(status: AdminAuthStatus.awaitingTwoFactor));
      case AdminAuthResultType.authenticated:
        emit(const AdminAuthState(status: AdminAuthStatus.authenticated));
      case AdminAuthResultType.failure:
        emit(
          AdminAuthState(
            status: AdminAuthStatus.failure,
            failure: result.failure,
          ),
        );
    }
  }
}
