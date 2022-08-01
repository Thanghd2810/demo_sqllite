import 'package:equatable/equatable.dart';
import 'package:sky_food/models/product_model.dart';

class SupplierWithProduct extends Equatable {
  const SupplierWithProduct({
    required this.supplierId,
    required this.supplierName,
    required this.products,
  });

  final int supplierId;
  final String supplierName;
  final List<ProductModel> products;

  @override
  List<Object?> get props => [supplierId, supplierName, products];
}
