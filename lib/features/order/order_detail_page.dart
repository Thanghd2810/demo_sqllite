import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/utils.dart';

import '../../core/const/constants.dart';
import '../../models/order_model.dart';
import '../../theme/theme.dart';
import '../../widgets/elements/assets_gen/assets.gen.dart';
import '../../widgets/elements/text_view.dart';
import '../../widgets/modules/customer_order_list.dart';

class OrderDetailPage extends HookConsumerWidget {
  const OrderDetailPage({
    Key? key,
    @QueryParam('order') this.order,
    @QueryParam('supplier_name') this.supplierName,
  })  : assert(order != null && supplierName != null),
        super(key: key);

  final OrderModel? order;
  final String? supplierName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 35.h,
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  background: Assets.images.icBeyondMeatMcdonalds
                      .image(height: 20, fit: BoxFit.cover),
                ),
                Align(
                  alignment: const Alignment(0, 1),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F9FD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _OrderInfo(
            order: order!,
            supplierName: supplierName!,
          ),
        ],
      ),
    );
  }
}

class _OrderInfo extends HookWidget {
  const _OrderInfo({
    Key? key,
    required this.order,
    required this.supplierName,
  }) : super(key: key);

  final OrderModel order;
  final String supplierName;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isMobile ? kDefaultPadding : kDefaultFatPadding,
          vertical: Responsive.isMobile ? 0 : kDefaultWidePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              order.name,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              fontColor: AppColors.black,
              fontSize: Responsive.isMobile ? FontSize.xLarge : FontSize.huge,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextView(
              ConvertNumber.formatPriceProductDisplay(order.price),
              fontColor: AppColors.red.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextView(
              order.description,
              maxLines: 10,
              fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
            ),
            const SizedBox(
              height: kDefaultExThinPadding,
            ),
            TextView(
              'Nhà cung cấp: ' + supplierName,
              maxLines: 2,
              fontSize: Responsive.isMobile ? FontSize.small : FontSize.large,
              fontColor: FontColor.darkGrey,
            ),
            const SizedBox(
              height: 80,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  'Danh sách đặt:',
                  fontSize:
                      Responsive.isMobile ? FontSize.large : FontSize.xLarge,
                ),
                CustomerOrderList(
                  customers: order.customers,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
