// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:core/local/database/dao/product/product_dao.dart';
import 'package:core/local/database/table/table.dart';
import 'package:dependencies/drift/drift.dart';

part 'database_module.g.dart';

@DriftDatabase(tables: [ProductDetailTable], daos: [ProductDao])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return SqfliteQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  );
}
