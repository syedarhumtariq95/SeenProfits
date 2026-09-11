import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../configs/router/admin_routes.dart';
import '../bloc/admin_auth_cubit.dart';
import '../bloc/admin_auth_state.dart';
import '../widgets/admin_auth_page_layout.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<AdminAuthCubit>()
          .requestPasswordReset(_emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdminAuthCubit, AdminAuthState>(
      builder: (context, state) {
        final loading = state.status == AdminAuthStatus.loading;
        final success = state.status == AdminAuthStatus.passwordResetSent;
        return AdminAuthPageLayout(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.forgotPassword,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(l10n.forgotPasswordDescription),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  enabled: !loading && !success,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    return RegExp(r'^\S+@\S+\.\S+$').hasMatch(value.trim())
                        ? null
                        : l10n.invalidEmail;
                  },
                ),
                if (success) ...[
                  const SizedBox(height: 16),
                  Text(
                    l10n.passwordResetMockSuccess,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loading || success ? null : _submit,
                  child: loading
                      ? Semantics(
                          label: l10n.sendingResetRequest,
                          child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Text(l10n.submit),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    AdminRouteNames.login,
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(l10n.backToLogin),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
