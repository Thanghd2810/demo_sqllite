import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/models/supplier_model.dart';
import 'package:sky_food/models/supplier_with_order.dart';

import '../models/order_model.dart';
import 'services/local_db/order_local_db.dart';
import 'services/local_db/supplier_local_db.dart';

final orderRepositoryProvider = Provider(
  (ref) => OrderRepository(
    orderDB: ref.read(orderLocalDBProvider),
    supplierLocalDB: ref.read(supplierLocalDBProvider),
  ),
);

class OrderRepository {
  OrderRepository({
    required OrderLocalDB orderDB,
    required SupplierLocalDB supplierLocalDB,
  })  : _orderDB = orderDB,
        _supplierLocalDB = supplierLocalDB;

  final OrderLocalDB _orderDB;
  final SupplierLocalDB _supplierLocalDB;

  /// get Supplier With Order
  Future<List<SupplierWithOrder>> findSupplierWithOrder() async {
    final suppliers = await _supplierLocalDB.findSupplierStatusIsShow();

    final orders = await _orderDB.findAll();

    return _mapSupplierWithOrder(suppliers: suppliers, orders: orders);
  }

  /// Insert order
  Future<void> insert(OrderModel order) async {
    await _orderDB.insertOrUpdate(order);
  }

  /// Delete Order
  Future<void> removeAll() async {
    await _orderDB.removeAll();
  }

  /// map Supplier with Order
  List<SupplierWithOrder> _mapSupplierWithOrder({
    required List<SupplierModel> suppliers,
    required List<OrderModel> orders,
  }) {
    final List<SupplierWithOrder> supplierWithOrders = [];
    final List<OrderModel> ordersTempt = [];

    for (final supplier in suppliers) {
      for (final order in orders) {
        if (order.idSupplier == supplier.id) {
          ordersTempt.add(
            OrderModel(
              id: order.id,
              idSupplier: order.idSupplier,
              name: order.name,
              price: order.price,
              imgPath: order.imgPath,
              description: order.description,
              customers: order.customers,
              quantity: order.quantity,
            ),
          );
        }
      }

      if (ordersTempt.isEmpty) continue;

      supplierWithOrders.add(
        SupplierWithOrder(
          supplierId: supplier.id,
          supplierName: supplier.name,
          orders: List.from(ordersTempt),
        ),
      );
      ordersTempt.clear();
    }

    return supplierWithOrders;
  }
}
