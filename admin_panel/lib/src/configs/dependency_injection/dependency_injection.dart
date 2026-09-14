import 'package:get_it/get_it.dart';

import '../../core/auth/admin_session.dart';
import '../../data/mock/mock_admin_session_repository.dart';
import '../../data/repositories/mock_business_repository_impl.dart';
import '../../data/repositories/mock_dashboard_repository_impl.dart';
import '../../data/repositories/mock_verification_repository_impl.dart';
import '../../domain/repositories/admin_session_repository.dart';
import '../../domain/repositories/business_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/repositories/verification_repository.dart';
import '../../presentation/features/auth/bloc/admin_auth_cubit.dart';
import '../../presentation/features/business_management/bloc/business_bloc.dart';
import '../../presentation/features/dashboard/bloc/dashboard_bloc.dart';
import '../../presentation/features/verification/bloc/verification_bloc.dart';
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
    if (!_instance.isRegistered<BusinessRepository>()) {
      _instance.registerLazySingleton<BusinessRepository>(
        MockBusinessRepositoryImpl.new,
      );
    }
    if (!_instance.isRegistered<BusinessBloc>()) {
      _instance.registerFactory(() => BusinessBloc(get<BusinessRepository>()));
    }
    if (!_instance.isRegistered<DashboardRepository>()) {
      _instance.registerLazySingleton<DashboardRepository>(
        MockDashboardRepositoryImpl.new,
      );
    }
    if (!_instance.isRegistered<DashboardBloc>()) {
      _instance
          .registerFactory(() => DashboardBloc(get<DashboardRepository>()));
    }
    if (!_instance.isRegistered<VerificationRepository>()) {
      _instance.registerLazySingleton<VerificationRepository>(
        MockVerificationRepositoryImpl.new,
      );
    }
    if (!_instance.isRegistered<VerificationBloc>()) {
      _instance.registerFactory(
        () => VerificationBloc(get<VerificationRepository>()),
      );
    }
  }
}
