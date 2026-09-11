import 'package:get_it/get_it.dart';

import '../../core/auth/admin_session.dart';
import '../../data/mock/mock_admin_session_repository.dart';
import '../../domain/repositories/admin_session_repository.dart';
import '../../presentation/features/auth/bloc/admin_auth_cubit.dart';
import '../localization/admin_locale_cubit.dart';

class AdminDependencyInjection {
  AdminDependencyInjection._();

  static final GetIt _instance = GetIt.I;

  static T get<T extends Object>() => _instance<T>();

  static void init() {
    if (!_instance.isRegistered<AdminLocaleCubit>()) {
      _instance.registerLazySingleton(AdminLocaleCubit.new);
    }
    if (!_instance.isRegistered<AdminSession>()) {
      _instance.registerLazySingleton(AdminSession.new);
    }
    if (!_instance.isRegistered<AdminSessionRepository>()) {
      _instance.registerLazySingleton<AdminSessionRepository>(
        () => MockAdminSessionRepository(get<AdminSession>()),
      );
    }
    if (!_instance.isRegistered<AdminAuthCubit>()) {
      _instance.registerLazySingleton(
        () => AdminAuthCubit(get<AdminSessionRepository>()),
      );
    }
  }
}
