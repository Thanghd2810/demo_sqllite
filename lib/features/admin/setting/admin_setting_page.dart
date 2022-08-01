import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/features/admin/setting/admin_setting_view_model.dart';
import 'package:sky_food/theme/theme.dart';
import 'package:sky_food/widgets/elements/button/button.dart';
import 'package:sky_food/widgets/elements/text_area/text_area.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

class AdminSettingPage extends HookConsumerWidget {
  const AdminSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final adminVM = ref.read(adminSettingVMProvider);

    final errorMes = ref.watch(
      adminSettingVMProvider.select((value) => value.errorMes),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          width: Responsive.isMobile ? 90.w : 60.w,
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultFatPadding,
            horizontal: kDefaultWidePadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.skyBlue[100],
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextView(
                  "Nhập mật khẩu",
                  fontColor: AppColors.orange,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: kDefaultWidePadding,
                ),
                TextArea(
                  onSaved: (value) {
                    adminVM.password = value ?? "";
                  },
                  onChanged: (value) {
                    adminVM.errorMes = "";
                  },
                  isRequired: true,
                  textType: TextType.password,
                  textInputAction: TextInputAction.done,
                ),
                if (errorMes.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultExThinPadding,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextView(
                        errorMes,
                        fontSize: 18,
                        fontColor: AppColors.red,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                else
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                Button(
                  "Xác nhận",
                  buttonSize: ButtonSize.infinityWith,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      adminVM.verifyPass();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
