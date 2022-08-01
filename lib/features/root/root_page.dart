import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/widgets/elements/assets_gen/assets.gen.dart';

import '../../route/router.dart';

class RootPage extends HookConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        OrderRoute(),
        AdminSettingRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: tabsRouter.setActiveIndex,
          items: [
            _NavigationItem(
              label: 'home',
              iconSrc: Assets.images.icDietGray.path,
              activeIconSrc: Assets.images.icDiet.path,
            ),
            _NavigationItem(
              label: 'order',
              iconSrc: Assets.images.icTrolleyGray.path,
              activeIconSrc: Assets.images.icTrolley.path,
            ),
            _NavigationItem(
              label: 'admin',
              iconSrc: Assets.images.icInsuranceGray.path,
              activeIconSrc: Assets.images.icInsurance.path,
            ),
          ],
        );
      },
    );
  }
}

class _NavigationItem extends BottomNavigationBarItem {
  _NavigationItem({
    required String label,
    required String iconSrc,
    required String activeIconSrc,
  }) : super(
          label: label,
          icon: Image.asset(
            iconSrc,
            height: Responsive.isMobile ? 24 : 34,
            fit: BoxFit.fill,
          ),
          activeIcon: Image.asset(
            activeIconSrc,
            height: Responsive.isMobile ? 24 : 34,
            fit: BoxFit.fill,
          ),
        );
}
