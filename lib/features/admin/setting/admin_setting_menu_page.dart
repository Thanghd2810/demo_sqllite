import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/theme/theme.dart';

import '../../../core/utils/utils.dart';
import '../../../route/router.dart';
import '../../../widgets/elements/text_view.dart';

class AdminSettingMenuPage extends HookWidget {
  const AdminSettingMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppRouter().replace(const RootRoute());
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: AppColors.white,
              titleSpacing: 0,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back,
                        size: Responsive.isMobile ? 20 : 30,
                      ),
                      onPressed: () {
                        AppRouter().replace(const RootRoute());
                      }),
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 30,
                  ),
                  const SizedBox(
                    width: kDefaultExThinPadding,
                  ),
                  TextView(
                    "Admin",
                    fontSize:
                        Responsive.isMobile ? FontSize.large : FontSize.huge,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      size: Responsive.isMobile ? 20 : 30,
                    ),
                  )
                ],
              )),
          body: ListView(
            children: [
              Container(
                color: AppColors.skyBlue[100],
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultThinPadding,
                  horizontal: kDefaultWidePadding,
                ),
                child: TextView(
                  "Sky Food",
                  fontSize:
                      Responsive.isMobile ? FontSize.large : FontSize.huge,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _MenuItem(
                title: "Nhà cung cấp",
                subtitle: "Thêm, sửa, xoá, nhà cung cấp",
                onTap: () {
                  AppRouter().push(const AdminSupplierRoute());
                },
              ),
              _MenuItem(
                title: "Sản phẩm",
                subtitle: "Thêm, sửa, xoá, sản phẩm",
                onTap: () {
                  AppRouter().push(const AdminProductRoute());
                },
              ),
            ],
          )),
    );
  }
}

class _MenuItem extends HookWidget {
  const _MenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultExThinPadding,
            vertical: kDefaultPadding,
          ),
          child: ListTile(
            onTap: onTap,
            title: TextView(
              title,
              fontSize: Responsive.isMobile ? FontSize.large : FontSize.huge,
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextView(
              subtitle,
              fontSize: Responsive.isMobile ? FontSize.large : FontSize.huge,
              fontColor: AppColors.grey,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: Responsive.isMobile ? 25 : 30,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
