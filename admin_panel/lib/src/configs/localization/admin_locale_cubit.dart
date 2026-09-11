import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLocaleCubit extends Cubit<Locale> {
  AdminLocaleCubit() : super(const Locale('en'));

  void changeLocale(Locale locale) => emit(locale);
}
