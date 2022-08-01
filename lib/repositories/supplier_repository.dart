import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/models/supplier_model.dart';

import 'services/local_db/supplier_local_db.dart';

final supplierRepositoryProvider = Provider(
  (ref) => SupplierRepository(supplierDB: ref.read(supplierLocalDBProvider)),
);

class SupplierRepository {
  SupplierRepository({
    required SupplierLocalDB supplierDB,
  }) : _supplierDB = supplierDB;

  final SupplierLocalDB _supplierDB;

  Future<SupplierModel> insert(SupplierModel supplier) async {
    final id = await _supplierDB.insert(
      SupplierModel(name: supplier.name, isShow: supplier.isShow),
    );

    return SupplierModel(id: id, name: supplier.name, isShow: supplier.isShow);
  }

  Future<List<SupplierModel>> findAll() async {
    return await _supplierDB.findAll();
  }

  Future<void> remove(int id) async {
    return await _supplierDB.remove(id);
  }

  Future<void> update(SupplierModel supplier) async {
    await _supplierDB.update(supplier);
  }
}
