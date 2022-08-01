import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_food/core/utils/utils.dart';

import '../../../core/const/constants.dart';
import '../../theme/theme.dart';
import '../../widgets/elements/button/button.dart';
import '../../widgets/elements/lazy_future_builder.dart';
import '../../widgets/elements/text_view.dart';
import 'splash_view_model.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.skyBlue,
              highlightColor: AppColors.orange,
              child: TextView(
                'Sky Food',
                fontSize: Responsive.isMobile ? FontSize.massive : 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultExThinPadding),
            FutureBuilder(
              future: ref.read(splashCtrlProvider).init(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return LazyFutureBuilder(
                    lazyFuture: () async {
                      await ref.read(splashCtrlProvider).init();
                    },
                    builder: (context, future, isFutureExecuting) {
                      if (isFutureExecuting == false) {
                        return Button(
                          "Thử lại",
                          buttonType: ButtonType.accent,
                          onPressed: future,
                        );
                      }

                      return Container();
                    },
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
