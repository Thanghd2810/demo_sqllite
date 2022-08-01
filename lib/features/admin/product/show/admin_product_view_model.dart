import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/models/product_model.dart';
import '../../../../models/supplier_with_product.dart';
import '../../../../repositories/product_repository.dart';
import '../../../../route/router.dart';

final adminProductViewModelProvider =
    ChangeNotifierProvider.autoDispose<AdminProductViewModel>((ref) {
  return AdminProductViewModel(ref.read);
});

class AdminProductViewModel extends ViewModel {
  AdminProductViewModel(Reader read)
      : _read = read,
        super(read);
  final Reader _read;

  ProductRepository get _productRepo => _read(productRepositoryProvider);

  AsyncValue<List<SupplierWithProduct>> supplierWithProducts =
      const AsyncLoading();

  bool isShow = true;

  @override
  void onInit() {
    _getSupplierWithProducts();
    super.onInit();
  }

  Future<void> _getSupplierWithProducts() async {
    try {
      final data = await _productRepo.findSupplierWithProduct();
      supplierWithProducts = AsyncData(data);
    } catch (e) {
      supplierWithProducts = AsyncError(e);
      handleExceptions(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> goToAddProductPage() async {
    await router.push(const AdminAddProductRoute());
    supplierWithProducts = const AsyncLoading();
    await _getSupplierWithProducts();
  }

  Future<void> goToUpdateProductPage(ProductModel product) async {
    final isReLoadPage = await router.push(
      AdminProductUpdateRoute(product: product),
    );
    if (isReLoadPage == null || isReLoadPage is! bool || !isReLoadPage) return;

    supplierWithProducts = const AsyncLoading();
    await _getSupplierWithProducts();
  }

  Future<void> remove(ProductModel product) async {
    try {
      await _productRepo.remove(product.id);

      final supplierWithProductTemp = _supplierWithProductsMaybeWhen();
      _removeProductInUI(supplierWithProductTemp, product);

      supplierWithProducts = AsyncData(supplierWithProductTemp);
      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  Future<void> updateStatus(ProductModel product) async {
    try {
      final newProduct = product.copyWith(isShow: isShow);

      await _productRepo.update(newProduct);

      supplierWithProducts = AsyncData(_updateStatusUI(product, newProduct));

      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  List<SupplierWithProduct> _updateStatusUI(
    ProductModel oldProduct,
    ProductModel newProduct,
  ) {
    final supplierWithProductTemp = _supplierWithProductsMaybeWhen();

    final supplierWithProduct = supplierWithProductTemp.firstWhere(
      (sp) => sp.supplierId == oldProduct.idSupplier,
    );

    final index = supplierWithProduct.products.indexWhere(
      (p) => p.id == oldProduct.id,
    );

    supplierWithProduct.products[index] = newProduct;

    return supplierWithProductTemp;
  }

  void _removeProductInUI(
    List<SupplierWithProduct> supplierWithProductTemp,
    ProductModel product,
  ) {
    final supplierWithProduct = supplierWithProductTemp.firstWhere(
      (sp) => sp.supplierId == product.idSupplier,
    );

    supplierWithProduct.products.remove(product);
  }

  List<SupplierWithProduct> _supplierWithProductsMaybeWhen() {
    return supplierWithProducts.maybeWhen(
      data: (data) => data,
      orElse: () => [],
    );
  }
}
