import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/repositories/product_repository.dart';
import '../../models/supplier_with_product.dart';

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(ref.read),
);

class HomeViewModel extends ViewModel {
  HomeViewModel(Reader read)
      : _read = read,
        super(read);

  final Reader _read;

  ProductRepository get _productRepo => _read(productRepositoryProvider);

  AsyncValue<List<SupplierWithProduct>> supplierWithProducts =
      const AsyncLoading();

  @override
  void onInit() {
    _getSupplierWithProduct();
    super.onInit();
  }

  /// get Supplier with Order
  Future<void> _getSupplierWithProduct() async {
    try {
      final data = await _productRepo.findSupplierStatusIsShowing();
      supplierWithProducts = AsyncData(data);
    } catch (e) {
      supplierWithProducts = AsyncError(e);
      handleExceptions(e);
    }
    updateState();
  }
}
