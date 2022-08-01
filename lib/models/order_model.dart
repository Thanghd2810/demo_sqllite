import 'dart:convert';

import 'package:sky_food/core/utils/extensions/bool.dart';
import 'package:sky_food/core/utils/extensions/int.dart';
import 'package:sky_food/models/product_model.dart';

class OrderModel extends ProductModel {
  final List<String> customers;
  final int quantity;
  final bool isOrderDone;

  const OrderModel({
    required final int id,
    required final int idSupplier,
    required final String name,
    required final double price,
    required final String imgPath,
    required final String description,
    required this.customers,
    required this.quantity,
    this.isOrderDone = false,
  }) : super(
          id: id,
          idSupplier: idSupplier,
          name: name,
          price: price,
          imgPath: imgPath,
          description: description,
        );

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      idSupplier: map['id_supplier'],
      name: map['name'],
      price: map['price'],
      imgPath: map['img_path'],
      description: map['description'],
      customers: List<String>.from(jsonDecode(map['customers'])),
      quantity: map['quantity'],
      isOrderDone: (map['is_order_done'] as int).toBool(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_supplier': idSupplier,
      'name': name,
      'price': price,
      'img_path': imgPath,
      'description': description,
      'customers': jsonEncode(customers),
      'quantity': quantity,
      'is_order_done': isOrderDone.toInt(),
    };
  }
}
