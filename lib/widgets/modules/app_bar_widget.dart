import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

import '../../../core/const/constants.dart';
import '../../../theme/theme.dart';
import '../../core/utils/utils.dart';

class AppBarWidget extends HookConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.title,
    this.customTitle,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.titleSpacing,
  })  : tabTitles = null,
        assert(title != null || customTitle != null),
        super(key: key);

  const AppBarWidget.withTab({
    Key? key,
    this.title,
    this.customTitle,
    required this.tabTitles,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.titleSpacing,
  })  : assert(tabTitles != null || (title != null || customTitle != null)),
        super(key: key);

  final String? title;
  final Widget? customTitle;
  final List<String>? tabTitles;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final double? titleSpacing;

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      title: title == null ? customTitle : _TitleAppBar(title!),
      actions: actions,
      leading: leading,
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      bottom: tabTitles == null ? null : _buildTabBar(),
    );
  }

  double get heightAppBar {
    if (tabTitles == null) {
      return 56.0; // 56px: height Appbar default
    }

    if (Responsive.isMobile) {
      return 76.0; // 56px + 20px (height bottom TabBar)
    }

    return 120.0; // 56px + 64px (height bottom TabBar)
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      enableFeedback: true,
      indicatorSize: TabBarIndicatorSize.label,
      physics: const BouncingScrollPhysics(),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.skyBlue,
      ),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      tabs: tabTitles!.map<Tab>((title) {
        return Tab(
          height: Responsive.isMobile ? 36 : 46,
          child: _ItemTabBar(title),
        );
      }).toList(),
    );
  }
}

class _TitleAppBar extends StatelessWidget {
  const _TitleAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextView(
      title,
      fontColor: AppColors.skyBlue[900],
      fontSize: Responsive.isMobile ? FontSize.xLarge : FontSize.massive,
      fontWeight: FontWeight.bold,
    );
  }
}

class _ItemTabBar extends HookWidget {
  const _ItemTabBar(this.content, {Key? key}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            Responsive.isMobile ? kDefaultThinPadding : kDefaultWidePadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.skyBlue, width: 1),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextView(
          content,
          fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
