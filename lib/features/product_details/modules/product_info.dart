import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/product_details/product_details_view_model.dart';
import 'package:sky_food/theme/theme.dart';
import 'package:sky_food/widgets/elements/text_view.dart';
import 'package:sky_food/widgets/modules/select_box.dart';

import '../../../models/product_model.dart';
import '../../../widgets/elements/text_area/text_area.dart';

class ProductInfo extends HookConsumerWidget {
  const ProductInfo({
    Key? key,
    required this.product,
    required this.nameSupplier,
  }) : super(key: key);

  final ProductModel product;
  final String nameSupplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile ? kDefaultPadding : kDefaultFatPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            product.name,
            maxLines: 2,
            fontWeight: FontWeight.bold,
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.xLarge : FontSize.huge,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          TextView(
            ConvertNumber.formatPriceProductDisplay(product.price),
            fontColor: AppColors.red.withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          TextView(
            product.description,
            maxLines: 10,
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          TextView(
            'Nhà cung cấp: ' + nameSupplier,
            maxLines: 2,
            fontSize: Responsive.isMobile ? FontSize.small : FontSize.large,
            fontColor: FontColor.darkGrey,
          ),
          const SizedBox(
            height: 50,
          ),
          TextView(
            "Tên:",
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          Form(
            key: ref.read(productDetailsViewModel).formKey,
            child: TextArea(
              isRequired: true,
              textType: TextType.text,
              onSaved: (value) {
                ref.read(productDetailsViewModel).customerName = value!;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          TextView(
            "Team:",
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          HookConsumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final readWM = ref.read(productDetailsViewModel);

              return SelectBox<String>(
                onChanged: (String value) {
                  readWM.teamSelected = value;
                },
                itemsSrc: readWM.teamsName,
                value: ref.watch(productDetailsViewModel.select(
                  (vm) => vm.teamSelected,
                )),
                itemBuilder: (String value) {
                  return TextView(
                    value,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Responsive.isMobile ? FontSize.large : FontSize.xLarge,
                    fontColor: AppColors.orange,
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          TextView(
            "Số lượng:",
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          HookConsumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QualityButton(
                    onTap: () {
                      ref.read(productDetailsViewModel).quantity--;
                    },
                    icon: Icons.remove_outlined,
                    iconColor: AppColors.orange.withOpacity(0.8),
                    backgroundColor: AppColors.skyBlue[100]!,
                  ),
                  SizedBox(
                    width: Responsive.isMobile ? 50 : 80,
                    child: TextView(
                      ref.watch(productDetailsViewModel.select(
                        (vm) => vm.quantity.toString(),
                      )),
                      textAlign: TextAlign.center,
                      fontSize:
                          Responsive.isMobile ? FontSize.large : FontSize.xHuge,
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.skyBlue[900],
                    ),
                  ),
                  _QualityButton(
                    onTap: () {
                      ref.read(productDetailsViewModel).quantity++;
                    },
                    icon: Icons.add_outlined,
                    iconColor: AppColors.white,
                    backgroundColor: AppColors.orange.withOpacity(0.6),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: kDefaultThinPadding,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class _QualityButton extends StatelessWidget {
  const _QualityButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Responsive.isMobile ? 40 : 60,
        height: Responsive.isMobile ? 40 : 60,
        child: Icon(
          icon,
          size: Responsive.isMobile ? 30 : 36,
          color: iconColor,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Responsive.isMobile ? 15 : 20),
        ),
      ),
    );
  }
}
