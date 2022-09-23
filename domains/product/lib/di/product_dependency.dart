import 'package:dependencies/get_it/get_it.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';

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
  }

  void _registerRepository() {
    sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(remoteSource: sl(), mapper: sl()));
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
  }
}
