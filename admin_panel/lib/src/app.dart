import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../l10n/app_localizations.dart';
import 'configs/dependency_injection/dependency_injection.dart';
import 'configs/localization/admin_locale_cubit.dart';
import 'configs/localization/localization_extensions.dart';
import 'configs/router/admin_router.dart';
import 'configs/router/admin_routes.dart';
import 'configs/theme/admin_theme_config.dart';
import 'presentation/features/auth/bloc/admin_auth_cubit.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AdminDependencyInjection.get<AdminLocaleCubit>(),
        ),
        BlocProvider.value(
          value: AdminDependencyInjection.get<AdminAuthCubit>(),
        ),
      ],
      child: BlocBuilder<AdminLocaleCubit, Locale>(
        builder: (context, locale) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.appName,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AdminThemeConfig.theme,
          initialRoute: AdminRouteNames.login,
          onGenerateRoute: AdminRouter.onGenerateRoute,
        ),
      ),
    );
  }
}