import 'package:authentication/data/repository/authentication_repository_impl.dart';
import 'package:authentication/data/source/authentication_local_source.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:authentication/domain/usecases/cache_onboarding_usecase.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class AuthenticationDependency {
  AuthenticationDependency() {
    _registerDataSources();
    _registerRepository();
    _registerUseCase();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<AuthenticationLocalSource>(
        () => AuthenticationLocalSourceImpl(sharedPreferences: sl()));
  }

  void _registerRepository() {
    sl.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(authenticationLocalSource: sl()));
  }

  void _registerUseCase() {
    sl.registerLazySingleton<CacheOnboardingUseCase>(
        () => CacheOnboardingUseCase(authenticationRepository: sl()));

    sl.registerLazySingleton<GetOnboardingStatusUseCase>(
        () => GetOnboardingStatusUseCase(authenticationRepository: sl()));
  }
}
