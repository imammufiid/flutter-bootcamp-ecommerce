import 'package:core/local/database/database_module.dart';
import 'package:core/local/database/table/product_detail_table.dart';
import 'package:dependencies/drift/drift.dart';

part 'product_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [ProductDetailTable])
class ProductDao extends DatabaseAccessor<MyDatabase> with _$ProductDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ProductDao(MyDatabase db) : super(db);

  Future<void> save(ProductDetailTableCompanion data) =>
      into(productDetailTable).insert(data, mode: InsertMode.insertOrReplace);

  Future<void> deleteProduct(String productUrl) => (delete(productDetailTable)
        ..where((tbl) => tbl.imageUrl.equals(productUrl)))
      .go();

  Future<ProductDetailTableData> getFavoriteProductByUrl(String productUrl) =>
      (select(productDetailTable)
            ..where((tbl) => tbl.imageUrl.equals(productUrl)))
          .getSingle();

  Future<List<ProductDetailTableData>> getFavoriteProducts() =>
      select(productDetailTable).get();

  Stream<List<ProductDetailTableData>> getFavProducts() =>
      select(productDetailTable).watch();
}
