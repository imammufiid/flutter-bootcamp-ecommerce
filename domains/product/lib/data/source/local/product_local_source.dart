import 'package:core/local/database/database_module.dart';

abstract class ProductLocalSource {
  const ProductLocalSource();

  Future<bool> save(ProductDetailTableCompanion data);

  Stream<List<ProductDetailTableData>> getFavProducts();

  Future<bool> deleteProduct(String productUrl);

  Future<ProductDetailTableData> getFavoriteProductByUrl(String productUrl);
}

class ProductLocalSourceImpl extends ProductLocalSource {
  final MyDatabase database;

  ProductLocalSourceImpl({required this.database});

  @override
  Future<bool> save(ProductDetailTableCompanion data) async {
    try {
      await database.productDao.save(data);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Stream<List<ProductDetailTableData>> getFavProducts() {
    return database.productDao.getFavProducts();
  }

  @override
  Future<bool> deleteProduct(String productUrl) async {
    try {
      await database.productDao.deleteProduct(productUrl);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetailTableData> getFavoriteProductByUrl(
      String productUrl) async {
    try {
      return await database.productDao.getFavoriteProductByUrl(productUrl);
    } catch (e) {
      rethrow;
    }
  }
}
