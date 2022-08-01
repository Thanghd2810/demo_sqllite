import 'package:equatable/equatable.dart';

import 'order_model.dart';

class SupplierWithOrder extends Equatable {
  const SupplierWithOrder({
    required this.supplierId,
    required this.supplierName,
    required this.orders,
  });

  final int supplierId;
  final String supplierName;
  final List<OrderModel> orders;

  @override
  List<Object?> get props => [supplierId, supplierName, orders];
}
