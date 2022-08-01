import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';

import '../../../models/supplier_model.dart';
import '../../../repositories/supplier_repository.dart';

final adminSupplierViewModelProvider =
    ChangeNotifierProvider.autoDispose<AdminSupplierViewModel>((ref) {
  return AdminSupplierViewModel(ref.read);
});

class AdminSupplierViewModel extends ViewModel {
  AdminSupplierViewModel(Reader read)
      : _read = read,
        super(read);
  final Reader _read;

  SupplierRepository get _supplierRepo => _read(supplierRepositoryProvider);

  String supplierName = "";
  bool isShow = true;

  AsyncValue<List<SupplierModel>> suppliers = const AsyncLoading();

  @override
  void onInit() {
    _findAll();
    super.onInit();
  }

  Future<void> insert() async {
    try {
      final supplierTemp = _suppliersMaybeWhen();
      final data = SupplierModel(name: supplierName);
      final supplier = await _supplierRepo.insert(data);
      supplierTemp.add(supplier);
      suppliers = AsyncData(supplierTemp);
      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  Future<void> _findAll() async {
    try {
      final data = await _supplierRepo.findAll();
      suppliers = AsyncData(data);
      updateState();
    } catch (e) {
      suppliers = AsyncError(e);
      handleExceptions(e);
    } finally {
      updateState();
    }
  }

  Future<void> remove(SupplierModel supplier) async {
    try {
      final supplierTemp = _suppliersMaybeWhen();
      await _supplierRepo.remove(supplier.id);
      supplierTemp.remove(supplier);
      suppliers = AsyncData(supplierTemp);
      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  Future<void> update(SupplierModel supplier) async {
    final newSupplier = supplier.copyWith(name: supplierName);
    await _supplierRepo.update(newSupplier);
  }

  Future<void> updateName(SupplierModel supplier) async {
    try {
      final newSupplier = supplier.copyWith(name: supplierName);
      await _supplierRepo.update(newSupplier);

      suppliers = AsyncData(_updateNameUI(supplier.id));

      router.pop();
      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  Future<void> updateStatus(SupplierModel supplier) async {
    try {
      final newSupplier = supplier.copyWith(isShow: isShow);
      await _supplierRepo.update(newSupplier);

      suppliers = AsyncData(_updateStatusUI(supplier.id));

      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }

  List<SupplierModel> _suppliersMaybeWhen() {
    return suppliers.maybeWhen(
      data: (data) => data,
      orElse: () => [],
    );
  }

  List<SupplierModel> _updateNameUI(int id) {
    final supplerTemp = _suppliersMaybeWhen();
    final indexSupplier = supplerTemp.indexWhere(
      (element) => element.id == id,
    );

    supplerTemp[indexSupplier] = SupplierModel(
      id: id,
      name: supplierName,
      isShow: supplerTemp[indexSupplier].isShow,
    );
    return supplerTemp;
  }

  List<SupplierModel> _updateStatusUI(int id) {
    final supplerTemp = _suppliersMaybeWhen();

    final indexSupplier = supplerTemp.indexWhere(
      (element) => element.id == id,
    );

    supplerTemp[indexSupplier] = SupplierModel(
      id: id,
      name: supplerTemp[indexSupplier].name,
      isShow: isShow,
    );
    return supplerTemp;
  }
}
