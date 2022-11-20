import 'package:dependencies/get_it/get_it.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/data/source/local/product_local_source.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/delete_product_usecase.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';
import 'package:product/domain/usecase/get_favorite_product_by_url_usecase.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';
import 'package:product/domain/usecase/save_product_usecase.dart';

class ProductDependency {
  ProductDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<ProductRemoteSource>(
        () => ProductRemoteSourceImpl(dio: sl()));

    sl.registerLazySingleton<ProductLocalSource>(
        () => ProductLocalSourceImpl(database: sl()));
  }

  void _registerRepository() {
    sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        remoteSource: sl(), localSource: sl(), mapper: sl()));
  }

  void _registerMapper() {
    sl.registerLazySingleton<ProductMapper>(() => ProductMapper());
  }

  void _registerUseCase() {
    sl.registerLazySingleton<GetBannerUseCase>(
      () => GetBannerUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetProductCategoryUseCase>(
      () => GetProductCategoryUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetSellerUseCase>(
      () => GetSellerUseCase(repository: sl()),
    );
    sl.registerLazySingleton<SaveProductUseCase>(
      () => SaveProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetFavoriteProductByUrlUseCase>(
      () => GetFavoriteProductByUrlUseCase(repository: sl()),
    );
  }
}
