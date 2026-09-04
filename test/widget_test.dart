// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seen_profits/l10n/app_localizations.dart';
import 'package:seen_profits/src/configs/localization/locale_bloc/locale_bloc.dart';
import 'package:seen_profits/src/configs/router/routes.dart';
import 'package:seen_profits/src/ui/presentation/screens/auth/auth_entry_screen.dart';
import 'package:seen_profits/src/ui/presentation/screens/auth/authentication_screens.dart';
import 'package:seen_profits/src/ui/generics/widgets/buttons/app_primary_button.dart';
import 'package:seen_profits/src/ui/presentation/screens/onboarding/role_selection_screen.dart';
import 'package:seen_profits/src/ui/presentation/screens/home/home_screens.dart';

void main() {
  Widget app({String? initialRoute, Locale? locale}) => BlocProvider(
        create: (_) => LocaleBloc(),
        child: MaterialApp(
          key: UniqueKey(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: CustomRouter.routes,
          initialRoute: initialRoute ?? CustomRouter.roleSelectionRouteName,
        ),
      );

  testWidgets('role selection presents business and investor paths', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(app());

    await tester.pumpAndSettle();

    expect(find.text('Business'), findsOneWidget);
    expect(find.text('Investor'), findsOneWidget);
  });

  testWidgets('splash opens authentication instead of role selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      app(initialRoute: CustomRouter.splashScreenRouteName),
    );
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pumpAndSettle();

    expect(find.byType(AuthEntryScreen), findsOneWidget);
    expect(find.byType(RoleSelectionScreen), findsNothing);
  });

  testWidgets('login leads to role selection', (WidgetTester tester) async {
    await tester.pumpWidget(
      app(initialRoute: CustomRouter.loginRouteName),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byType(AppPrimaryButton));
    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();

    expect(find.byType(RoleSelectionScreen), findsOneWidget);
  });

  testWidgets('registration leads through OTP to role selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      app(initialRoute: CustomRouter.registerRouteName),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byType(AppPrimaryButton));
    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<AuthenticationScreen>(find.byType(AuthenticationScreen))
          .page,
      AuthenticationPage.otp,
    );

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();

    expect(find.byType(RoleSelectionScreen), findsOneWidget);
  });

  testWidgets('forgot password leads to reset and back to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      app(initialRoute: CustomRouter.forgotPasswordRouteName),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AuthenticationScreen>(find.byType(AuthenticationScreen))
          .page,
      AuthenticationPage.resetPassword,
    );

    await tester.ensureVisible(find.byType(AppPrimaryButton));
    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AuthenticationScreen>(find.byType(AuthenticationScreen))
          .page,
      AuthenticationPage.login,
    );
  });

  testWidgets('each role opens its matching home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Business'));
    await tester.pumpAndSettle();
    expect(find.byType(BusinessHomeScreen), findsOneWidget);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Investor'));
    await tester.tap(find.text('Investor'));
    await tester.pumpAndSettle();
    expect(find.byType(InvestorHomeScreen), findsOneWidget);
  });

  testWidgets('Urdu localization uses RTL directionality', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(app(locale: const Locale('ur')));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(RoleSelectionScreen));
    expect(Directionality.of(context), TextDirection.rtl);
  });
}
