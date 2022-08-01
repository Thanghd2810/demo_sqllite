import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/models/product_model.dart';

import '../../../core/services/sqlite/sqlite.dart';

final productLocalDBProvider = Provider(
  (ref) => ProductLocalDB(ref.read(dbHelperProvider)),
);

class ProductLocalDB extends LocalDataBase {
  ProductLocalDB(DBHelper dbHelper) : super(dbHelper);

  String tableName = "Product";

  /// Get all Product information
  Future<List<ProductModel>> findAll() async {
    final list = await dbHelper.getAll(tableName);

    return list.map(ProductModel.fromMap).toList();
  }

  /// Get Product which status is_show = 1
  Future<List<ProductModel>> findProductStatusIsShow() async {
    final list = await dbHelper.query(
      tableName,
      where: 'is_show = ?',
      whereArgs: [1],
    );

    return list.map(ProductModel.fromMap).toList();
  }

  /// Delete all Product information
  Future<void> removeAll() async {
    final list = await dbHelper.getAll(tableName);

    final productList = list.map(ProductModel.fromMap).toList();

    for (final product in productList) {
      await dbHelper.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [product.id],
      );
    }
  }

  /// Delete Product information
  Future<void> remove(int id) async {
    await dbHelper.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Update Product information
  Future<void> update(ProductModel product) async {
    await dbHelper.update(
      tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  /// Insert all Product information
  Future<void> insertAll(List<ProductModel> productList) async {
    for (final product in productList) {
      await dbHelper.insert(tableName, product.toMap());
    }
  }

  /// Insert Product information
  Future<void> insert(ProductModel product) async {
    await dbHelper.insert(tableName, product.toMap());
  }
}
