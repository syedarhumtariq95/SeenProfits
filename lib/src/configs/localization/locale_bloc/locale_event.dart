part of 'locale_bloc.dart';

sealed class LocaleEvent {
  const LocaleEvent();
}

class LoadLocale extends LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  const ChangeLocale(this.locale);

  final Locale locale;
}
