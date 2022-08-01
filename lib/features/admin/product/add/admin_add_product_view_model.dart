import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/extensions/string.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/models/product_model.dart';
import 'package:sky_food/models/supplier_model.dart';
import 'package:sky_food/repositories/supplier_repository.dart';
import '../../../../repositories/product_repository.dart';
import '../../../../widgets/elements/dialog/toast.dart';

final adminAddProductVMProvider =
    ChangeNotifierProvider.autoDispose<AdminAddProductViewModel>((ref) {
  return AdminAddProductViewModel(ref.read);
});

class AdminAddProductViewModel extends ViewModel {
  AdminAddProductViewModel(Reader read)
      : _read = read,
        super(read);

  final Reader _read;

  ProductRepository get _productRepo => _read(productRepositoryProvider);
  SupplierRepository get _supplierRepo => _read(supplierRepositoryProvider);

  final formKey = GlobalKey<FormState>();

  SupplierModel _supplierSelected = SupplierModel();
  SupplierModel get supplierSelected => _supplierSelected;
  set supplierSelected(SupplierModel supplier) {
    _supplierSelected = supplier;
    notifyListeners();
  }

  File? _imgPicked;
  File? get imgPicked => _imgPicked;
  set imgPicked(File? file) {
    _imgPicked = file;
    notifyListeners();
  }

  String productName = '';
  String productPrice = '';
  String productDescription = '';
  String productImgPath = '';

  final List<SupplierModel> suppliers = [];

  @override
  void onInit() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getSupplier();
    });

    super.onInit();
  }

  Future<void> _getSupplier() async {
    final listSupplier = await _supplierRepo.findAll();
    suppliers.addAll(listSupplier);
    supplierSelected = suppliers[0];
  }

  Future<void> insertProduct(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        ShowToast.warning(context, message: " vui lòng nhập đúng định dạng");
        return;
      }

      formKey.currentState!.save();

      final newProduct = ProductModel(
        idSupplier: supplierSelected.id,
        name: productName,
        price: productPrice.toDouble() ?? 0.0,
        imgPath: productImgPath,
        description: productDescription,
      );

      await _productRepo.insert(newProduct);
      formKey.currentState!.reset();
      ShowToast.success(context);
    } catch (e) {
      handleExceptions(e);
      ShowToast.error(context);
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
