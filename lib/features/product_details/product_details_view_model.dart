import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/models/order_model.dart';

import '../../models/product_model.dart';
import '../../repositories/order_repository.dart';
import '../../widgets/elements/dialog/toast.dart';

const List<String> _teamName = [
  'D1',
  'D2',
  'QA Tester',
  'BrSE',
  'Rupy',
  'Sky Dart',
  'BO',
  'Sale',
  'Alpha'
];

const List<String> _titleButtons = [
  'Mua đi mấy cưng',
  'Phải mua',
  'Giải cíu bé đi',
  'ÉT Ô ÉT',
  'Dậy đi ông cháu eii',
  'Cơm đến rồi ông cháu eii',
  'Mua để đi ông cháu',
];

final productDetailsViewModel = ChangeNotifierProvider.autoDispose(
  (ref) {
    return ProductDetailsViewModel(ref.read);
  },
);

class ProductDetailsViewModel extends ViewModel {
  ProductDetailsViewModel(Reader read)
      : _read = read,
        super(read);

  final Reader _read;

  OrderRepository get _orderRepo => _read(orderRepositoryProvider);

  final formKey = GlobalKey<FormState>();

  final List<String> teamsName = _teamName;
  final List<String> titleButtons = _titleButtons;
  String customerName = '';
  String _teamSelected = 'D1';

  String get teamSelected => _teamSelected;
  set teamSelected(String team) {
    _teamSelected = team;
    notifyListeners();
  }

  int _quality = 1;
  int get quantity => _quality;
  set quantity(int number) {
    if ((quantity + number) <= 1) return;

    _quality = number;
    notifyListeners();
  }

  String getTitleOrderButton() {
    final random = Random();
    final index = random.nextInt(titleButtons.length - 1);
    return titleButtons[index];
  }

  Future<void> insert(
    BuildContext context, {
    required ProductModel product,
  }) async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      final order = OrderModel(
        id: product.id,
        idSupplier: product.idSupplier,
        name: product.name,
        price: product.price,
        imgPath: product.imgPath,
        description: product.description,
        customers: ['$customerName-$teamSelected-$quantity'],
        quantity: quantity,
      );
      await _orderRepo.insert(order);
      ShowToast.success(context, message: "Đã thêm vào danh sách đặt hàng");
    } catch (e) {
      handleExceptions(e);
      ShowToast.success(context, message: "Có lỗi sảy ra. huhu");
    }
  }
}
