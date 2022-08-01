import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/sqlite/sqlite.dart';
import '../../../models/order_model.dart';

final orderLocalDBProvider = Provider(
  (ref) => OrderLocalDB(ref.read(dbHelperProvider)),
);

class OrderLocalDB extends LocalDataBase {
  OrderLocalDB(DBHelper dbHelper) : super(dbHelper);

  String tableName = "OrderProduct";

  /// Get all Order Information
  Future<List<OrderModel>> findAll() async {
    final list = await dbHelper.getAll(tableName);

    return list.map(OrderModel.fromMap).toList();
  }

  Future<OrderModel?> find(int id) async {
    final orders = await dbHelper.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (orders.isEmpty) {
      return null;
    }

    return OrderModel.fromMap(orders.first);
  }

  /// Delete all Order Information
  Future<void> removeAll() async {
    final list = await dbHelper.getAll(tableName);

    final listOrder = list.map(OrderModel.fromMap).toList();

    for (final order in listOrder) {
      await dbHelper.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [order.id],
      );
    }
  }

  /// Insert Order Information
  Future<void> insert(OrderModel order) async {
    await dbHelper.insert(
      tableName,
      order.toMap(),
    );
  }

  /// Update Customer and Quantity Order Information
  Future<void> _updateCustomerAndQuantity({
    required int id,
    required String customers,
    required int quantity,
  }) async {
    await dbHelper.update(
      tableName,
      {'customers': customers, 'quantity': quantity},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Insert or Update Order Information
  Future<void> insertOrUpdate(OrderModel newOrder) async {
    final orderModel = await find(newOrder.id);

    if (orderModel == null) {
      await insert(newOrder);
      return;
    }

    orderModel.customers.addAll(newOrder.customers);
    final quantity = orderModel.quantity + newOrder.quantity;
    await _updateCustomerAndQuantity(
      id: newOrder.id,
      customers: jsonEncode(orderModel.customers),
      quantity: quantity,
    );
  }
}
