import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

import '../../core/const/constants.dart';
import '../../theme/theme.dart';
import '../modules/app_bar_widget.dart';

class NoDataPage extends HookWidget {
  const NoDataPage({
    Key? key,
    this.titleAppBar,
    this.customTitleAppBar,
    this.messageBody = '',
    this.child,
  }) : super(key: key);

  final String? titleAppBar;
  final Widget? customTitleAppBar;
  final String messageBody;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customTitleAppBar == null && titleAppBar == null
          ? null
          : AppBarWidget(
              title: titleAppBar,
              customTitle: customTitleAppBar,
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Center(
          child: child ??
              TextView(
                messageBody,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontDarkColor: AppColors.black,
              ),
        ),
      ),
    );
  }
}
