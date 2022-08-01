import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/models/product_model.dart';
import 'package:sky_food/models/supplier_with_product.dart';
import 'package:sky_food/repositories/services/local_db/supplier_local_db.dart';

import '../models/supplier_model.dart';
import 'services/local_db/product_local_db.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    productsDB: ref.read(productLocalDBProvider),
    supplierDB: ref.read(supplierLocalDBProvider),
  ),
);

class ProductRepository {
  ProductRepository({
    required ProductLocalDB productsDB,
    required SupplierLocalDB supplierDB,
  })  : _productsLocalDB = productsDB,
        _supplierLocalDB = supplierDB;

  final ProductLocalDB _productsLocalDB;
  final SupplierLocalDB _supplierLocalDB;

  /// get Supplier With Order
  Future<List<SupplierWithProduct>> findSupplierWithProduct() async {
    final suppliers = await _supplierLocalDB.findAll();

    final products = await _productsLocalDB.findAll();

    return _mapSupplierWithProduct(suppliers: suppliers, products: products);
  }

  /// get Supplier With Order has status isShow = true
  Future<List<SupplierWithProduct>>
  findSupplierStatusIsShowing() async {
    final suppliers = await _supplierLocalDB.findSupplierStatusIsShow();

    final products = await _productsLocalDB.findProductStatusIsShow();

    return _mapSupplierWithProduct(suppliers: suppliers, products: products);
  }

  /// insert Product
  Future<void> insert(ProductModel product) async {
    await _productsLocalDB.insert(product);
  }

  /// insert Product
  Future<void> remove(int id) async {
    await _productsLocalDB.remove(id);
  }

  /// insert Product
  Future<void> update(ProductModel product) async {
    await _productsLocalDB.update(product);
  }

  /// map Supplier with Order
  List<SupplierWithProduct> _mapSupplierWithProduct({
    required List<SupplierModel> suppliers,
    required List<ProductModel> products,
  }) {
    final List<SupplierWithProduct> supplierWithProducts = [];
    final List<ProductModel> productTempts = [];

    for (final supplier in suppliers) {
      for (final product in products) {
        if (product.idSupplier == supplier.id) {
          productTempts.add(
            ProductModel(
              id: product.id,
              idSupplier: product.idSupplier,
              name: product.name,
              price: product.price,
              imgPath: product.imgPath,
              description: product.description,
              isShow: product.isShow,
            ),
          );
        }
      }

      supplierWithProducts.add(
        SupplierWithProduct(
          supplierId: supplier.id,
          supplierName: supplier.name,
          products: [...productTempts],
        ),
      );

      productTempts.clear();
    }

    return supplierWithProducts;
  }
}
