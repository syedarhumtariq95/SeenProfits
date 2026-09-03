import 'package:flutter/material.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import 'auth_entry_screen.dart';

class AuthPlaceholderScreen extends StatelessWidget {
  const AuthPlaceholderScreen({
    super.key,
    required this.role,
    required this.isLogin,
  });

  final SeenProfitsRole role;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isBusiness = role == SeenProfitsRole.business;
    final title = switch ((isBusiness, isLogin)) {
      (true, true) => localizations.loginBusiness,
      (true, false) => localizations.registerBusiness,
      (false, true) => localizations.loginInvestor,
      (false, false) => localizations.registerInvestor,
    };

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isLogin ? Icons.login_rounded : Icons.person_add_alt_1,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localizations.authPlaceholderMessage,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: Text(localizations.backToWelcome),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
