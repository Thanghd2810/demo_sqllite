import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/extensions/string.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/models/product_model.dart';
import 'package:sky_food/widgets/elements/dialog/toast.dart';

import '../../../../core/utils/utils.dart';
import '../../../../repositories/product_repository.dart';

final adminProductUpdateVMProvider =
    ChangeNotifierProvider.autoDispose<AdminProductUpdateViewModel>((ref) {
  return AdminProductUpdateViewModel(ref.read);
});

class AdminProductUpdateViewModel extends ViewModel {
  AdminProductUpdateViewModel(Reader read)
      : _read = read,
        super(read);
  final Reader _read;

  ProductRepository get _productRepo => _read(productRepositoryProvider);

  final formKey = GlobalKey<FormState>();

  bool isShow = true;
  String productName = '';
  String productPrice = '';
  String productDescription = '';
  String productImgPath = '';

  File? _imgPicked;
  File? get imgPicked => _imgPicked;
  set imgPicked(File? file) {
    _imgPicked = file;
    notifyListeners();
  }

  late ProductModel productModel;

  void initData(ProductModel product) {
    isShow = product.isShow;
    productName = product.name;
    productPrice = ConvertNumber.removeLastDot0(product.price.toString());
    productDescription = product.description;
    productImgPath = product.imgPath;
    if (productImgPath.isNotEmpty) imgPicked = File(productImgPath);
    productModel = product;
  }

  Future<void> update(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) return;

      formKey.currentState!.save();

      final newProduct = productModel.copyWith(
        name: productName,
        price: productPrice.toDouble() ?? 0.0,
        description: productDescription,
        imgPath: productImgPath,
        isShow: isShow,
      );

      await _productRepo.update(newProduct);
      ShowToast.success(context, message: "Cập nhập thành công");
      router.pop<bool>(true);
    } catch (e) {
      ShowToast.error(context);
      handleExceptions(e);
    }
  }

  Future<void> pickImg(BuildContext context) async {
    ShowToast.info(context, message: "Tính năng đang được phát triển");

    /// TODO: implement logic pick image
    //
    //   final XFile? picked = await ImagePicker().pickImage(
    //     source: ImageSource.gallery,
    //     imageQuality: 80
    //   );
    //
    //   if (picked != null) {
    //     imgPicked = File(picked.path);
    //   }
  }
}
