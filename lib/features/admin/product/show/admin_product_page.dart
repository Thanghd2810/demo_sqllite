import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/features/admin/product/show/admin_product_view_model.dart';
import 'package:sky_food/widgets/modules/app_bar_widget.dart';

import '../../../../core/const/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../widgets/elements/loading/indicator.dart';
import '../../../../widgets/elements/no_data_page.dart';
import '../modules/admin_product_cart.dart';

class AdminProductPage extends HookConsumerWidget {
  const AdminProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchVM = ref.watch(adminProductViewModelProvider);

    return watchVM.supplierWithProducts.when(
      loading: () {
        return const NoDataPage(
          titleAppBar: "Quản lý sản phẩm",
          child: Indicator(radius: 14),
        );
      },
      error: (_, __) {
        return const NoDataPage(
          titleAppBar: "Quản lý sản phẩm",
          messageBody: 'Có lỗi rồi, bé không tìm thấy món nào cả.\nHuhu :((',
        );
      },
      data: (data) {
        if (data.isEmpty) {
          return const NoDataPage(
            titleAppBar: "Quản lý sản phẩm",
            messageBody: 'Thêm món đi bạn êi',
          );
        }
        return DefaultTabController(
          length: data.length,
          child: Scaffold(
            appBar: AppBarWidget.withTab(
              tabTitles: data.map((s) => s.supplierName).toList(),
              title: "Quản lý sản phẩm",
              actions: [
                IconButton(
                  onPressed: () {
                    ref
                        .read(adminProductViewModelProvider)
                        .goToAddProductPage();
                  },
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    size: Responsive.isMobile ? 24 : 30,
                  ),
                ),
              ],
            ),
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: data.map<Widget>((supplierWithProduct) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  itemCount: supplierWithProduct.products.length,
                  itemBuilder: (_, idx) {
                    return AdminProductCart(
                      product: supplierWithProduct.products[idx],
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
