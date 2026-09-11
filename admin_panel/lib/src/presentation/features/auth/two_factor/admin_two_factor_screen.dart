import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../configs/router/admin_routes.dart';
import '../bloc/admin_auth_cubit.dart';
import '../bloc/admin_auth_state.dart';
import '../widgets/admin_auth_error_message.dart';
import '../widgets/admin_auth_page_layout.dart';
import '../widgets/otp_code_input.dart';

class AdminTwoFactorScreen extends StatefulWidget {
  const AdminTwoFactorScreen({super.key});

  @override
  State<AdminTwoFactorScreen> createState() => _AdminTwoFactorScreenState();
}

class _AdminTwoFactorScreenState extends State<AdminTwoFactorScreen> {
  Timer? _resendTimer;
  var _resendSeconds = 30;
  var _code = '';
  var _resent = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    setState(() => _resendSeconds = 30);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
        return;
      }
      setState(() => _resendSeconds -= 1);
    });
  }

  Future<void> _resendCode() async {
    await context.read<AdminAuthCubit>().resendTwoFactorCode();
    if (!mounted) {
      return;
    }
    setState(() => _resent = true);
    _startResendCountdown();
  }

  void _verify() {
    if (_code.length != 6) {
      return;
    }
    context.read<AdminAuthCubit>().verifyTwoFactorCode(_code);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<AdminAuthCubit, AdminAuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AdminAuthStatus.authenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AdminRouteNames.dashboard,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final loading = state.status == AdminAuthStatus.loading;
        return AdminAuthPageLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.twoFactorAuthentication,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(l10n.enterVerificationCodeDescription),
              const SizedBox(height: 24),
              IgnorePointer(
                ignoring: loading,
                child: OtpCodeInput(
                  autofocus: true,
                  onChanged: (value) => setState(() => _code = value),
                ),
              ),
              if (state.status == AdminAuthStatus.failure) ...[
                const SizedBox(height: 16),
                AdminAuthErrorMessage(message: l10n.invalidVerificationCode),
              ],
              if (_resent) ...[
                const SizedBox(height: 16),
                Text(
                  l10n.mockCodeResent,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loading || _code.length != 6 ? null : _verify,
                child: loading
                    ? Semantics(
                        label: l10n.verifyingCode,
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Text(l10n.verify),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _resendSeconds == 0 && !loading ? _resendCode : null,
                child: Text(
                  _resendSeconds == 0
                      ? l10n.resendCode
                      : l10n.resendCodeIn(_resendSeconds),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await context
                      .read<AdminAuthCubit>()
                      .cancelTwoFactorChallenge();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed(
                      AdminRouteNames.login,
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: Text(l10n.backToLogin),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.mockTwoFactorHint,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}
