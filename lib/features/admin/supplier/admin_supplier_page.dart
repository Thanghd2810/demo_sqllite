import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/admin/supplier/admin_supplier_view_model.dart';
import 'package:sky_food/widgets/modules/app_bar_widget.dart';

import '../../../core/const/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/elements/button/button.dart';
import '../../../widgets/elements/loading/indicator.dart';
import '../../../widgets/elements/no_data_page.dart';
import '../../../widgets/elements/text_area/text_area.dart';
import '../../../widgets/elements/text_view.dart';
import 'modules/admin_suppiler_cart.dart';

class AdminSupplierPage extends HookWidget {
  const AdminSupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.skyBlue[50],
        appBar: const AppBarWidget(
          title: "Quản lý nhà cung cấp",
        ),
        body: const _AdminSupplierList());
  }
}

class _AdminSupplierList extends HookConsumerWidget {
  const _AdminSupplierList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final adminSupplierVM = ref.read(adminSupplierViewModelProvider);

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultThinPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              "Nhà cung cấp:",
              fontColor: AppColors.black,
              fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: kDefaultThinPadding,
            ),
            TextArea(
              onSaved: (value) {
                adminSupplierVM.supplierName = value!;
              },
              textType: TextType.text,
              fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
              isRequired: true,
            ),
            const SizedBox(
              height: kDefaultFatPadding,
            ),
            SizedBox(
              width: 100.w,
              height: Responsive.isMobile ? 40 : 50,
              child: LoadingButton(
                "Thêm",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    adminSupplierVM.insert();
                  }
                },
              ),
            ),
            const SizedBox(
              height: kDefaultFatPadding,
            ),
            TextView(
              "Danh sách nhà cung cấp:",
              fontColor: AppColors.black,
              fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
              child: ref.watch(adminSupplierViewModelProvider).suppliers.when(
                loading: () {
                  return const NoDataPage(
                    child: Indicator(radius: 14),
                  );
                },
                error: (_, __) {
                  return const NoDataPage(
                    messageBody: 'Không thể lấy dữ liệu',
                  );
                },
                data: (data) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return AdminSupplierCart(
                        supplier: data[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
