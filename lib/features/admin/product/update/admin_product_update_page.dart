import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/models/product_model.dart';
import 'package:sky_food/theme/theme.dart';
import 'package:sky_food/widgets/elements/text_view.dart';
import 'package:sky_food/widgets/modules/app_bar_widget.dart';

import '../../../../widgets/elements/button/button.dart';
import '../../../../widgets/elements/text_area/text_area.dart';
import 'admin_product_update_view_model.dart';

class AdminProductUpdatePage extends HookWidget {
  const AdminProductUpdatePage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Cập nhập sản phẩm",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultWidePadding),
          child: _Body(product: product),
        ),
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readVM = ref.read(adminProductUpdateVMProvider);
    useEffect(() {
      readVM.initData(product);
      return;
    }, []);

    return Form(
      key: readVM.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kDefaultPadding,
          ),
          TextView(
            "Tên sản phẩm:",
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          TextArea(
            value: product.name,
            onSaved: (value) {
              readVM.productName = value!;
            },
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fillColor: AppColors.white,
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          TextView(
            "Giá:",
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          TextArea(
            value: readVM.productPrice,
            onSaved: (value) {
              readVM.productPrice = value!;
            },
            textType: TextType.number,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          TextView(
            "Mô tả:",
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          TextArea(
            value: product.description,
            onSaved: (value) {
              readVM.productDescription = value!;
            },
            maxLines: 7,
            minLines: 7,
            textType: TextType.text,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          TextView(
            "Ảnh:",
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          Button("Chọn ảnh", onPressed: () => readVM.pickImg(context)),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            height: readVM.imgPicked != null ? 30.h : 0,
            child: readVM.imgPicked != null
                ? Image.file(
                    readVM.imgPicked!,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(
            height: kDefaultWidePadding,
          ),
          SizedBox(
            width: 100.w,
            height: 55,
            child: LoadingButton(
              "Cập nhập sản phẩm",
              onPressed: () async {
                await readVM.update(context);
              },
            ),
          ),
          const SizedBox(
            height: kDefaultFatPadding,
          ),
        ],
      ),
    );
  }
}
