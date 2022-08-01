import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';
import 'package:sky_food/models/supplier_with_order.dart';
import 'package:sky_food/widgets/elements/dialog/confirm_dialog.dart';

import '../../core/services/pdf/pdf_service.dart';
import '../../repositories/order_repository.dart';
import '../../route/router.dart';

final orderViewModelProvider =
    ChangeNotifierProvider.autoDispose<OderViewModel>(
  (ref) => OderViewModel(ref.read),
);

class OderViewModel extends ViewModel {
  OderViewModel(Reader read)
      : _read = read,
        super(read);

  final Reader _read;

  OrderRepository get _orderRepo => _read(orderRepositoryProvider);

  AsyncValue<List<SupplierWithOrder>> supplierWithOrders = const AsyncLoading();

  bool get hasDataSupplierWithOrders => supplierWithOrders.maybeWhen(
        data: (data) {
          if (data.isEmpty) return false;

          return true;
        },
        error: (_, __) => false,
        loading: () => false,
        orElse: () => false,
      );

  @override
  void onInit() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getSupplierWithOrder();
    });
    super.onInit();
  }

  /// get Supplier with Order
  Future<void> _getSupplierWithOrder() async {
    try {
      final data = await _orderRepo.findSupplierWithOrder();

      supplierWithOrders = AsyncData(data);
    } catch (e) {
      supplierWithOrders = AsyncError(e);
      handleExceptions(e);
    }
    notifyListeners();
  }

  Future<void> generatePDf() async {
    final List<File> listFile = [];

    for (final supplierWithOrder in supplierWithOrders.value!) {
      final pdfFile = await PdfService.generatePDf(supplierWithOrder);

      listFile.add(pdfFile);
    }

    if (listFile.isNotEmpty) {
      showAdaptiveActionSheet(
        context: context,
        actions: <BottomSheetAction>[
          for (int i = 0; i < listFile.length; i++)
            BottomSheetAction(
              title: Text(listFile[i].path.split("_").last),
              onPressed: () {
                router.push(
                  OrderPDFRoute(file: listFile[i]),
                );
              },
            ),
        ],
      );
    }
  }

  Future<void> deleteOrders() async {
    try {
      final result = await showConfirmDialog(
        context,
        messages: "Bạn có muốn xoá không?",
      );

      if (!(result ?? false)) return;

      await _orderRepo.removeAll();
      supplierWithOrders = const AsyncData([]);
      notifyListeners();
    } catch (e) {
      handleExceptions(e);
    }
  }
}
