import 'package:equatable/equatable.dart';
import 'package:sky_food/core/utils/extensions/bool.dart';
import 'package:sky_food/core/utils/extensions/int.dart';

class ProductModel extends Equatable {
  final int id;
  final int idSupplier;
  final String name;
  final double price;
  final String imgPath;
  final String description;
  final bool isShow;

  const ProductModel({
    this.id = -1,
    required this.idSupplier,
    required this.name,
    required this.price,
    this.imgPath = "",
    this.description = "",
    this.isShow = true,
  });

  @override
  List<Object?> get props => [id, idSupplier, name, price];

  ProductModel copyWith({
    String? name,
    double? price,
    String? imgPath,
    String? description,
    bool? isShow,
  }) {
    return ProductModel(
      id: id,
      idSupplier: idSupplier,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      isShow: isShow ?? this.isShow,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      idSupplier: map['id_supplier'],
      name: map['name'],
      price: map['price'],
      imgPath: map['img_path'],
      description: map['description'],
      isShow: (map['is_show'] as int).toBool(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_supplier': idSupplier,
      'name': name,
      'price': price,
      'img_path': imgPath,
      'description': description,
      'is_show': isShow.toInt(),
    };
  }
}
