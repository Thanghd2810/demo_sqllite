import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/models/product_model.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/elements/assets_gen/assets.gen.dart';
import '../../../../widgets/elements/dialog/confirm_dialog.dart';
import '../show/admin_product_view_model.dart';

class AdminProductCart extends HookConsumerWidget {
  const AdminProductCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readWM = ref.read(adminProductViewModelProvider);
    return Slidable(
      key: ValueKey(product),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          _EditActionButton(
            onTap: () => readWM.goToUpdateProductPage(product),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {},
          confirmDismiss: () async {
            final isDelete = await showConfirmDialog(
                  context,
                  messages: "Bạn có muốn xoá không?",
                ) ??
                false;

            if (isDelete) {
              readWM.remove(product);
            }
            return isDelete;
          },
          closeOnCancel: true,
        ),
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final isDelete = await showConfirmDialog(
                      context,
                      messages: "Bạn có muốn xoá không?",
                    ) ??
                    false;

                if (isDelete) {
                  readWM.remove(product);
                }
              },
              child: Container(
                height: 17.w,
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.3),
                  borderRadius:
                      BorderRadius.circular(Responsive.isMobile ? 20 : 30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Assets.images.icTrash.image(
                        height: Responsive.isMobile ? 25 : 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(kDefaultExThinPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Responsive.isMobile ? 20 : 30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 20,
              color: const Color(0xFFB0CCE1).withOpacity(0.32),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(
                Responsive.isMobile ? 5 : 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 14.w,
                    width: 14.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          Responsive.isMobile ? 20 : 30), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20), // Image radius
                        child: product.imgPath.isNotEmpty
                            ? Image.asset(
                                product.imgPath,
                                fit: BoxFit.fill,
                              )
                            : Assets.images.icBurger.image(
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: 15.w,
                      width: 10.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            product.name,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.isMobile
                                ? FontSize.large
                                : FontSize.massive,
                          ),
                          Responsive.isMobile
                              ? const SizedBox(height: 2)
                              : const SizedBox(height: kDefaultExThinPadding),
                          TextView(
                            product.description,
                            fontSize: Responsive.isMobile
                                ? FontSize.small
                                : FontSize.large,
                          ),
                          Responsive.isMobile
                              ? const SizedBox(height: 2)
                              : const SizedBox(height: kDefaultExThinPadding),
                          TextView(
                            ConvertNumber.shortenPriceProduct(product.price),
                            fontSize: Responsive.isMobile
                                ? FontSize.medium
                                : FontSize.xHuge,
                            fontColor: AppColors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: Responsive.isMobile ? 1 : 1.6,
                      child: Checkbox(
                        activeColor: AppColors.skyBlue,
                        shape: const CircleBorder(),
                        tristate: false,
                        value: product.isShow,
                        splashRadius: 20,
                        onChanged: (bool? value) {
                          readWM.isShow = value ?? false;
                          readWM.updateStatus(product);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EditActionButton extends HookConsumerWidget {
  const _EditActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Slidable.of(context)!.close();
          onTap.call();
        },
        child: Container(
          height: 17.w,
          decoration: BoxDecoration(
            color: AppColors.skyBlue[200],
            borderRadius: BorderRadius.circular(
              Responsive.isMobile ? 15 : 30,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Assets.images.icEdit.image(
                  height: Responsive.isMobile ? 25 : 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
