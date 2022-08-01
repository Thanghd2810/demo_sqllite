import 'package:equatable/equatable.dart';
import 'package:sky_food/core/utils/extensions/bool.dart';
import 'package:sky_food/core/utils/extensions/int.dart';

class SupplierModel extends Equatable {
  final int id;
  final String name;
  final bool isShow;

  const SupplierModel._({
    required this.id,
    required this.name,
    required this.isShow,
  });

  @override
  List<Object?> get props => [id, name];

  factory SupplierModel({
    int? id,
    String? name,
    bool? isShow,
  }) {
    return SupplierModel._(
      id: id ?? -1,
      name: name ?? '',
      isShow: isShow ?? true,
    );
  }

  SupplierModel copyWith({int? id, String? name, bool? isShow}) {
    return SupplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isShow: isShow ?? this.isShow,
    );
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id'],
      name: map['name'],
      isShow: (map['is_show'] as int).toBool(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'is_show': isShow.toInt(),
    };
  }
}
