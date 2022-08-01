import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/product_details/product_details_view_model.dart';
import 'package:sky_food/theme/theme.dart';

import '../../models/product_model.dart';
import '../../route/router.dart';
import '../../widgets/elements/assets_gen/assets.gen.dart';
import '../../widgets/elements/button/order_button.dart';
import 'modules/product_info.dart';

class ProductDetailsPage extends HookConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    required this.product,
    required this.nameSupplier,
  }) : super(key: key);

  final ProductModel product;
  final String nameSupplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readVM = ref.read(productDetailsViewModel);

    return WillPopScope(
      onWillPop: () async {
        AppRouter().replace(const RootRoute());
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppRouter().replace(const RootRoute());
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 35.h,
                flexibleSpace: Stack(
                  children: [
                    FlexibleSpaceBar(
                      background: product.imgPath.isNotEmpty
                          ? Image.file(File(product.imgPath))
                          : Assets.images.icBeyondMeatMcdonalds
                              .image(height: 20, fit: BoxFit.cover),
                    ),
                    Align(
                      alignment: const Alignment(0, 1.01),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.skyBlue[50],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Container(
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ProductInfo(
                  product: product,
                  nameSupplier: nameSupplier,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                Responsive.isMobile ? kDefaultPadding : kDefaultFatPadding,
            vertical:
                Responsive.isMobile ? kDefaultPadding : kDefaultWidePadding,
          ),
          child: OrderButton(
            readVM.getTitleOrderButton(),
            onTap: () {
              final key = ref.read(productDetailsViewModel).formKey;

              if (key.currentState!.validate()) {
                key.currentState!.save();
                readVM.insert(context, product: product);
              }
            },
            imgSrc: Assets.svgs.icChineseNoodles.path,
          ),
        ),
      ),
    );
  }
}
