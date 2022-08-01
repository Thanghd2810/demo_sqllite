import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/order/order_view_model.dart';
import 'package:sky_food/models/supplier_with_order.dart';
import 'package:sky_food/widgets/elements/text_view.dart';
import 'package:sky_food/widgets/modules/app_bar_widget.dart';

import '../../../widgets/elements/assets_gen/assets.gen.dart';
import '../../route/router.dart';
import '../../theme/theme.dart';
import '../../widgets/elements/cart/product_cart.dart';
import '../../widgets/elements/loading/indicator.dart';
import '../../widgets/elements/no_data_page.dart';

class OrderPage extends HookConsumerWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchVM = ref.watch(orderViewModelProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Danh Sách đặt món',
        actions: [
          if (watchVM.hasDataSupplierWithOrders)
            GestureDetector(
              onTap: () {
                ref.read(orderViewModelProvider).generatePDf();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultThinPadding,
                ),
                child: Assets.images.icPrinter.image(
                  width: Responsive.isMobile ? 22 : 32,
                ),
              ),
            ),
        ],
      ),
      body: watchVM.supplierWithOrders.when(
        loading: () {
          return const NoDataPage(
            child: Indicator(radius: 14),
          );
        },
        error: (_, __) {
          return const NoDataPage(
            messageBody: 'Có lỗi rồi, bé không tìm thấy món nào cả.\nHuhu :((',
          );
        },
        data: (data) {
          if (data.isEmpty) {
            return const NoDataPage(
              messageBody: 'Anh chị đặt món đi, bé đói lắm rồi!',
            );
          }

          return ListView.builder(
            primary: true,
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, indexOfSupplierWithOrders) {
              final supplierWithOrderData = data[indexOfSupplierWithOrders];
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: Responsive.isMobile
                      ? kDefaultExThinPadding
                      : kDefaultThinPadding,
                  horizontal: kDefaultThinPadding,
                ),
                padding: const EdgeInsets.all(kDefaultThinPadding),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.skyBlue[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: AppColors.skyBlue[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      supplierWithOrderData.supplierName,
                      fontColor: AppColors.black,
                      fontSize: Responsive.isMobile
                          ? FontSize.large
                          : FontSize.massive,
                      fontWeight: FontWeight.bold,
                    ),
                    _OrderListWidget(
                      supplierWithOrderData: supplierWithOrderData,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: watchVM.hasDataSupplierWithOrders
          ? FloatingActionButton(
              enableFeedback: true,
              mini: Responsive.isMobile,
              onPressed: () {
                ref.read(orderViewModelProvider).deleteOrders();
              },
              child: Assets.images.icTrashOrder.image(),
            )
          : null,
    );
  }
}

class _OrderListWidget extends HookWidget {
  const _OrderListWidget({
    Key? key,
    required this.supplierWithOrderData,
  }) : super(key: key);

  final SupplierWithOrder supplierWithOrderData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: supplierWithOrderData.orders.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final orderData = supplierWithOrderData.orders[index];

        return ProductCart(
          isOrderFeature: true,
          rightTitle: orderData.quantity.toString(),
          imgSrc: Assets.images.icBeyondMeatMcdonalds.path,
          title: orderData.name,
          subTitle: supplierWithOrderData.supplierName,
          onTap: () {
            AppRouter().push(
              OrderDetailRoute(
                order: orderData,
                supplierName: supplierWithOrderData.supplierName,
              ),
            );
          },
        );
      },
    );
  }
}
