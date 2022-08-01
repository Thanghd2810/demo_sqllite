import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/admin/supplier/admin_supplier_view_model.dart';
import 'package:sky_food/models/supplier_model.dart';

import '../../../../core/const/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/elements/button/button.dart';
import '../../../../widgets/elements/text_area/text_area.dart';
import '../../../../widgets/elements/text_view.dart';

Future showSupplierUpdateDialog(
  BuildContext context, {
  required SupplierModel supplier,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return SupplierUpdateDialog(supplier);
    },
  );
}

class SupplierUpdateDialog extends HookConsumerWidget {
  const SupplierUpdateDialog(this.supplier, {Key? key}) : super(key: key);

  final SupplierModel supplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminSupplierVM = ref.read(adminSupplierViewModelProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 5.h),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultFatPadding,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      content: Container(
        height: 35.w,
        width: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: kDefaultFatPadding,
                ),
                const TextView(
                  "Nhà cung cấp:",
                  fontColor: AppColors.black,
                  fontSize: FontSize.xSmall,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                TextArea(
                  value: supplier.name,
                  fontSize: FontSize.xSmall,
                  onSaved: (value) {
                    adminSupplierVM.supplierName = value!;
                  },
                ),
                const SizedBox(
                  height: kDefaultFatPadding,
                ),
                SizedBox(
                  width: 100.w,
                  height: 55,
                  child: LoadingButton(
                    "Thêm",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await adminSupplierVM.updateName(supplier);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: kDefaultFatPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
