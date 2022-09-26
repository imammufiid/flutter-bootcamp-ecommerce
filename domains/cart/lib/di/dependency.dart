import 'package:cart/data/mapper/cart_mapper.dart';
import 'package:cart/data/repository/cart_repository_impl.dart';
import 'package:cart/data/source/cart_remote_source.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:cart/domain/usecase/delete_cart_usecase.dart';
import 'package:cart/domain/usecase/get_carts_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class CartDependency {
  CartDependency() {
    _registerDataSources();
    _registerMappers();
    _registerRepositories();
    _registerUseCases();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<CartRemoteSource>(
        () => CartRemoteSourceImpl(dio: sl()));
  }

  void _registerMappers() {
    sl.registerLazySingleton<CartMapper>(() => CartMapper());
  }

  void _registerUseCases() {
    sl.registerLazySingleton<AddToCartUseCase>(
        () => AddToCartUseCase(repository: sl()));
    sl.registerLazySingleton<DeleteCartUseCase>(
        () => DeleteCartUseCase(repository: sl()));
    sl.registerLazySingleton<GetCartsUseCase>(
        () => GetCartsUseCase(repository: sl()));
  }

  void _registerRepositories() {
    sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(remoteSource: sl(), mapper: sl()));
  }
}
