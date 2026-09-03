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
import 'package:seen_profits/src/ui/presentation/screens/onboarding/role_selection_screen.dart';

void main() {
  testWidgets('role selection presents business and investor paths', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LocaleBloc(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const RoleSelectionScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Business'), findsOneWidget);
    expect(find.text('Investor'), findsOneWidget);
  });
}
