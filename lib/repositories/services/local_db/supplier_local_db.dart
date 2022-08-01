import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/models/supplier_model.dart';

import '../../../core/services/sqlite/sqlite.dart';
import '../../../models/supplier_model.dart';

final supplierLocalDBProvider = Provider(
  (ref) => SupplierLocalDB(ref.read(dbHelperProvider)),
);

class SupplierLocalDB extends LocalDataBase {
  SupplierLocalDB(DBHelper dbHelper) : super(dbHelper);

  String tableName = "Supplier";

  /// Get all Supplier information
  Future<List<SupplierModel>> findAll() async {
    final list = await dbHelper.getAll(tableName);

    return list.map(SupplierModel.fromMap).toList();
  }

  /// Get supplier which status is_show = 1
  Future<List<SupplierModel>> findSupplierStatusIsShow() async {
    final list = await dbHelper.query(
      tableName,
      where: 'is_show = ?',
      whereArgs: [1],
    );

    return list.map(SupplierModel.fromMap).toList();
  }

  /// Get all Supplier information
  Future<List<SupplierModel>> find() async {
    final list = await dbHelper.getAll(tableName);

    return list.map(SupplierModel.fromMap).toList();
  }

  /// Insert Supplier information
  Future<void> insertAll(List<SupplierModel> supplierList) async {
    for (final supplier in supplierList) {
      await dbHelper.insert(tableName, supplier.toMap());
    }
  }

  /// Insert Supplier
  ///
  /// Return Id record inserted
  Future<int> insert(SupplierModel supplier) async {
    return await dbHelper.insert(tableName, supplier.toMap());
  }

  /// Remove Supplier
  Future<void> remove(int id) async {
    await dbHelper.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Update Supplier
  Future<void> update(SupplierModel supplier) async {
    await dbHelper.update(
      tableName,
      supplier.toMap(),
      where: 'id = ?',
      whereArgs: [supplier.id],
    );
  }
}
