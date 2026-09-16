import 'package:get_it/get_it.dart';

import '../../core/auth/admin_session.dart';
import '../../data/mock/mock_admin_session_repository.dart';
import '../../data/repositories/mock_business_repository_impl.dart';
import '../../data/repositories/mock_dashboard_repository_impl.dart';
import '../../data/repositories/mock_verification_repository_impl.dart';
import '../../data/repositories/mock_user_repository_impl.dart';
import '../../data/repositories/mock_deal_repository_impl.dart';
import '../../data/repositories/mock_profit_repository_impl.dart';
import '../../data/repositories/mock_reports_repository_impl.dart';
import '../../data/repositories/mock_category_repository_impl.dart';
import '../../data/repositories/mock_notification_repository_impl.dart';
import '../../domain/repositories/admin_session_repository.dart';
import '../../domain/repositories/business_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/repositories/verification_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/deal_repository.dart';
import '../../domain/repositories/profit_repository.dart';
import '../../domain/repositories/reports_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../presentation/features/auth/bloc/admin_auth_cubit.dart';
import '../../presentation/features/business_management/bloc/business_bloc.dart';
import '../../presentation/features/dashboard/bloc/dashboard_bloc.dart';
import '../../presentation/features/verification/bloc/verification_bloc.dart';
import '../../presentation/features/user_management/bloc/user_bloc.dart';
import '../../presentation/features/deal_management/bloc/deal_bloc.dart';
import '../../presentation/features/profit_distribution/bloc/profit_bloc.dart';
import '../../presentation/features/reports/bloc/reports_bloc.dart';
import '../../presentation/features/categories/bloc/category_bloc.dart';
import '../../presentation/features/notifications/bloc/notification_bloc.dart';
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
    if (!_instance.isRegistered<UserRepository>()) {
      _instance
          .registerLazySingleton<UserRepository>(MockUserRepositoryImpl.new);
    }
    if (!_instance.isRegistered<UserBloc>()) {
      _instance.registerFactory(() => UserBloc(get<UserRepository>()));
    }
    if (!_instance.isRegistered<DealRepository>()) {
      _instance
          .registerLazySingleton<DealRepository>(MockDealRepositoryImpl.new);
    }
    if (!_instance.isRegistered<DealBloc>()) {
      _instance.registerFactory(() => DealBloc(get<DealRepository>()));
    }
    if (!_instance.isRegistered<ProfitRepository>()) {
      _instance.registerLazySingleton<ProfitRepository>(
        MockProfitRepositoryImpl.new,
      );
    }
    if (!_instance.isRegistered<ProfitBloc>()) {
      _instance.registerFactory(() => ProfitBloc(get<ProfitRepository>()));
    }
    if (!_instance.isRegistered<ReportsRepository>()) {
      _instance.registerLazySingleton<ReportsRepository>(
          MockReportsRepositoryImpl.new);
    }
    if (!_instance.isRegistered<ReportsBloc>()) {
      _instance.registerFactory(() => ReportsBloc(get<ReportsRepository>()));
    }
    if (!_instance.isRegistered<CategoryRepository>()) {
      _instance.registerLazySingleton<CategoryRepository>(
          MockCategoryRepositoryImpl.new);
    }
    if (!_instance.isRegistered<CategoryBloc>()) {
      _instance.registerFactory(() => CategoryBloc(get<CategoryRepository>()));
    }
    if (!_instance.isRegistered<NotificationRepository>()) {
      _instance.registerLazySingleton<NotificationRepository>(
        MockNotificationRepositoryImpl.new,
      );
    }
    if (!_instance.isRegistered<NotificationBloc>()) {
      _instance.registerFactory(
        () => NotificationBloc(get<NotificationRepository>()),
      );
    }
  }
}
