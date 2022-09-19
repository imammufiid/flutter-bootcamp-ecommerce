import 'package:dependencies/get_it/get_it.dart';
import 'package:profile/data/mapper/profile_mapper.dart';
import 'package:profile/data/repository/profile_repository_impl.dart';
import 'package:profile/data/source/profile_remote_source.dart';
import 'package:profile/domain/repository/profile_repository.dart';
import 'package:profile/domain/usecase/get_user_usecase.dart';
import 'package:profile/domain/usecase/update_user_usecase.dart';
import 'package:profile/domain/usecase/upload_photo_use_case.dart';

class ProfileDependency {
  ProfileDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<ProfileRemoteSource>(
        () => ProfileRemoteSourceImpl(dio: sl()));
  }

  void _registerMapper() {
    sl.registerLazySingleton<ProfileMapper>(() => ProfileMapper());
  }

  void _registerRepository() {
    sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(remoteSource: sl(), mapper: sl()));
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetUserUseCase>(
        () => GetUserUseCase(repository: sl()));

    sl.registerLazySingleton<UpdateUserUseCase>(
        () => UpdateUserUseCase(repository: sl()));

    sl.registerLazySingleton<UploadPhotoUseCase>(
        () => UploadPhotoUseCase(repository: sl()));
  }
}
