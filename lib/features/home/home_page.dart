import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/features/home/home_view_model.dart';
import 'package:sky_food/widgets/elements/cart/product_cart.dart';
import '../../core/utils/utils.dart';
import '../../route/router.dart';
import '../../theme/theme.dart';
import '../../widgets/elements/loading/indicator.dart';
import '../../widgets/elements/no_data_page.dart';
import '../../widgets/modules/app_bar_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeViewModelProvider);

    return homeVM.supplierWithProducts.when(
      loading: () {
        return const NoDataPage(
          customTitleAppBar: _TitleAppBar(),
          child: Indicator(radius: 14),
        );
      },
      error: (_, __) {
        return const NoDataPage(
          customTitleAppBar: _TitleAppBar(),
          messageBody: 'Có lỗi rồi, bé không tìm thấy món nào cả.\nHuhu :((',
        );
      },
      data: (data) {
        if (data.isEmpty) {
          return const NoDataPage(
            customTitleAppBar: _TitleAppBar(),
            messageBody: 'Thêm món đi bạn êi',
          );
        }

        return DefaultTabController(
          length: data.length,
          child: Scaffold(
            appBar: AppBarWidget.withTab(
              tabTitles: data.map((s) => s.supplierName).toList(),
              customTitle: const _TitleAppBar(),
            ),
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: data.map<Widget>(
                (supplierWithProduct) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        vertical: Responsive.isMobile
                            ? kDefaultExThinPadding / 2
                            : kDefaultPadding,
                        horizontal: kDefaultPadding),
                    itemBuilder: (context, index) {
                      final product = supplierWithProduct.products[index];
                      return ProductCart(
                        title: product.name,
                        subTitle: product.description,
                        imgSrc: product.imgPath,
                        rightTitle:
                            ConvertNumber.shortenPriceProduct(product.price),
                        onTap: () {
                          AppRouter().replace(
                            ProductDetailsRoute(
                              product: product,
                              nameSupplier: supplierWithProduct.supplierName,
                            ),
                          );
                        },
                      );
                    },
                    itemCount: supplierWithProduct.products.length,
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _TitleAppBar extends HookWidget {
  const _TitleAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.skyBlue[900],
          fontSize: Responsive.isMobile ? FontSize.huge : 40,
          fontWeight: FontWeight.bold,
        ),
        children: const [
          TextSpan(
            text: "Sky",
          ),
          TextSpan(
            text: "Food",
            style: TextStyle(color: AppColors.orange),
          ),
        ],
      ),
    );
  }
}
