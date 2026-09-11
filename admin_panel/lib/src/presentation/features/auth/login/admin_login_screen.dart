import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../configs/router/admin_routes.dart';
import '../bloc/admin_auth_cubit.dart';
import '../bloc/admin_auth_state.dart';
import '../widgets/admin_auth_error_message.dart';
import '../widgets/admin_auth_page_layout.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _rememberMe = false;
  var _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    context.read<AdminAuthCubit>().login(
          email: _emailController.text,
          password: _passwordController.text,
          rememberMe: _rememberMe,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<AdminAuthCubit, AdminAuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AdminAuthStatus.awaitingTwoFactor) {
          Navigator.of(context)
              .pushReplacementNamed(AdminRouteNames.loginTwoFactor);
        }
      },
      builder: (context, state) {
        final loading = state.status == AdminAuthStatus.loading;
        return AdminAuthPageLayout(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.adminLoginTitle,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(l10n.adminLoginDescription),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  enabled: !loading,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value.trim())) {
                      return l10n.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  enabled: !loading,
                  obscureText: _obscurePassword,
                  autofillHints: const [AutofillHints.password],
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: _obscurePassword
                          ? l10n.showPassword
                          : l10n.hidePassword,
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: loading
                          ? null
                          : (value) =>
                              setState(() => _rememberMe = value ?? false),
                    ),
                    Expanded(child: Text(l10n.rememberMe)),
                    TextButton(
                      onPressed: loading
                          ? null
                          : () => Navigator.of(context)
                              .pushNamed(AdminRouteNames.forgotPassword),
                      child: Text(l10n.forgotPassword),
                    ),
                  ],
                ),
                if (state.status == AdminAuthStatus.failure &&
                    state.failure != null) ...[
                  const SizedBox(height: 8),
                  AdminAuthErrorMessage(message: l10n.invalidCredentials),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? Semantics(
                          label: l10n.signingIn,
                          child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Text(l10n.login),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.mockLoginHint,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
