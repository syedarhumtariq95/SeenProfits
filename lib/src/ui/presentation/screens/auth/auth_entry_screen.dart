import 'package:flutter/material.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import '../../../../configs/router/routes.dart';
import '../../../generics/widgets/branding/app_logo.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';

enum SeenProfitsRole { business, investor }

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key, this.role});

  final SeenProfitsRole? role;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isBusiness = role == SeenProfitsRole.business;
    final title = role == null
        ? localizations.welcomeToSeenProfits
        : isBusiness
            ? localizations.welcomeBusiness
            : localizations.welcomeInvestor;
    final description = role == null
        ? localizations.authenticationDescription
        : isBusiness
            ? localizations.businessAuthDescription
            : localizations.investorAuthDescription;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: AppLogo(size: 104)),
                  const SizedBox(height: 36),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.55,
                        ),
                  ),
                  const SizedBox(height: 40),
                  AppPrimaryButton(
                    label: localizations.login,
                    icon: Icons.login_rounded,
                    onPressed: () => Navigator.of(context).pushNamed(
                      role == null
                          ? CustomRouter.loginRouteName
                          : isBusiness
                              ? CustomRouter.businessLoginRouteName
                              : CustomRouter.investorLoginRouteName,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed(
                        role == null
                            ? CustomRouter.registerRouteName
                            : isBusiness
                                ? CustomRouter.businessRegisterRouteName
                                : CustomRouter.investorRegisterRouteName,
                      ),
                      icon: const Icon(Icons.person_add_alt_1_outlined),
                      label: Text(localizations.register),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
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
