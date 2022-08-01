import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Set the indicator color
/// NOTE: Only white or black exists in [CupertinoActivityIndicator]
/// If you want to use other colors, please use other indicators.
/// ///
enum IndicatorColor {
  none,
  white,
  black,
}

class Indicator extends ConsumerWidget {
  const Indicator({
    Key? key,
    this.radius = 10.0,
    this.color = IndicatorColor.none,
  }) : super(key: key);

  final double radius;
  final IndicatorColor color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTheme(

        /// HACKME: Color cannot be specified with [CupertinoActivityIndicator].
        /// ///
        /// Utilizing the fact that the color changes in dark mode / light mode,
        /// Forcibly changed.
        /// * Please change the color only when the background is the same color
        ///  in dark mode and light mode.
        /// ///
        data: (color != IndicatorColor.none)
            ? CupertinoTheme.of(context).copyWith(
                brightness: (color == IndicatorColor.black)
                    ? Brightness.light
                    : Brightness.dark,
              )
            : CupertinoTheme.of(context),
        child: CupertinoActivityIndicator(radius: radius));
  }
}
