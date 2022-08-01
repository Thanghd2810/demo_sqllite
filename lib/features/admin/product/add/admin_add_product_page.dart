import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/models/supplier_model.dart';
import 'package:sky_food/theme/theme.dart';
import 'package:sky_food/widgets/elements/text_view.dart';
import 'package:sky_food/widgets/modules/app_bar_widget.dart';
import '../../../../widgets/elements/button/button.dart';
import '../../../../widgets/elements/text_area/text_area.dart';
import '../../../../widgets/modules/select_box.dart';
import 'admin_add_product_view_model.dart';

class AdminAddProductPage extends HookWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: "Thêm sản phẩm",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultWidePadding),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readVM = ref.read(adminAddProductVMProvider);
    final watchVM = ref.watch(adminAddProductVMProvider);

    return Form(
      key: readVM.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kDefaultPadding,
          ),
          TextView(
            "Nhà cung cấp:",
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          SelectBox<SupplierModel>(
            onChanged: (SupplierModel value) {
              watchVM.supplierSelected = value;
            },
            itemsSrc: watchVM.suppliers,
            value: watchVM.supplierSelected,
            itemBuilder: (SupplierModel value) {
              return TextView(
                value.name,
                fontWeight: FontWeight.bold,
                fontSize:
                    Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
                fontColor: AppColors.orange,
              );
            },
          ),
          const SizedBox(
            height: kDefaultWidePadding,
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
            onSaved: (value) {
              readVM.productName = value!;
            },
            textType: TextType.text,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            isRequired: true,
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
            onSaved: (value) {
              readVM.productPrice = value!;
            },
            textType: TextType.number,
            fontSize: Responsive.isMobile ? FontSize.medium : FontSize.xLarge,
            isRequired: true,
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
          const SizedBox(
            height: kDefaultExThinPadding,
          ),
          Button("Chọn ảnh", onPressed: () => readVM.pickImg(context)),
          const SizedBox(
            height: kDefaultExThinPadding,
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
              "Thêm",
              onPressed: () async {
                await readVM.insertProduct(context);
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
