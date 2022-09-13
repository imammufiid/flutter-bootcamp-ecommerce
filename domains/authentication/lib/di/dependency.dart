import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/data/repository/authentication_repository_impl.dart';
import 'package:authentication/data/source/local/authentication_local_source.dart';
import 'package:authentication/data/source/remote/authentication_remote_source.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:authentication/domain/usecases/cache_onboarding_usecase.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:authentication/domain/usecases/sign_in_usecase.dart';
import 'package:authentication/domain/usecases/sign_up_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class AuthenticationDependency {
  AuthenticationDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<AuthenticationLocalSource>(
        () => AuthenticationLocalSourceImpl(sharedPreferences: sl()));

    sl.registerLazySingleton<AuthenticationRemoteSource>(
        () => AuthenticationRemoteSourceImpl(dio: sl()));
  }

  void _registerRepository() {
    sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        authenticationLocalSource: sl(),
        authenticationRemoteSource: sl(),
        mapper: sl(),
      ),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<AuthenticationMapper>(
        () => AuthenticationMapper());
  }

  void _registerUseCase() {
    sl.registerLazySingleton<CacheOnboardingUseCase>(
        () => CacheOnboardingUseCase(authenticationRepository: sl()));

    sl.registerLazySingleton<GetOnboardingStatusUseCase>(
        () => GetOnboardingStatusUseCase(authenticationRepository: sl()));

    sl.registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(authenticationRepository: sl()));

    sl.registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(authenticationRepository: sl()));
  }
}
