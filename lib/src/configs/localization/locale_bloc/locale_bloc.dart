import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local_storage_sqflite/local_storage_sqflite.dart';
import '../../local_storage_sqflite/sqflite_model.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<LoadLocale>((event, emit) async {
      final savedLocale = await LocalStorageSqfLite.getDataByKey(_storageKey);
      if (savedLocale?.value == 'ur') {
        emit(const LocaleState(Locale('ur')));
      }
    });

    on<ChangeLocale>((event, emit) async {
      await LocalStorageSqfLite.insertData(
        Data(key: _storageKey, value: event.locale.languageCode),
      );
      emit(LocaleState(event.locale));
    });
  }

  static const String _storageKey = 'locale';
}
