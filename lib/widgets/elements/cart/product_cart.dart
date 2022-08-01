import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/core/utils/utils.dart';
import 'package:sky_food/widgets/elements/assets_gen/assets.gen.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

import '../../../theme/theme.dart';

class ProductCart extends HookWidget {
  const ProductCart({
    Key? key,
    this.isOrderFeature = false,
    required this.title,
    required this.subTitle,
    required this.imgSrc,
    required this.rightTitle,
    required this.onTap,
  }) : super(key: key);

  final bool isOrderFeature;
  final String title;
  final String subTitle;
  final String imgSrc;
  final String rightTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Responsive.isMobile
            ? kDefaultExThinPadding / 2
            : kDefaultExThinPadding,
      ),
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
          onTap: onTap,
          splashColor: AppColors.skyBlueAccent[700],
          borderRadius: BorderRadius.circular(Responsive.isMobile ? 20 : 30),
          child: Padding(
            padding: EdgeInsets.all(Responsive.isMobile ? 6 : 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 14.w,
                  width: 14.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(20), // Image radius
                      child: imgSrc.isNotEmpty
                          ? Image.asset(
                              imgSrc,
                              fit: BoxFit.fill,
                            )
                          : Assets.images.icBurger.image(
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.isMobile
                      ? kDefaultExThinPadding
                      : kDefaultPadding,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        title,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.isMobile
                            ? FontSize.large
                            : FontSize.massive,
                      ),
                      SizedBox(
                        height: Responsive.isMobile
                            ? kDefaultExThinPadding / 2
                            : kDefaultThinPadding,
                      ),
                      TextView(
                        subTitle,
                        fontSize: Responsive.isMobile
                            ? FontSize.small
                            : FontSize.xLarge,
                        fontColor: FontColor.darkGrey,
                      ),
                    ],
                  ),
                ),
                TextView(
                  isOrderFeature ? 'x $rightTitle' : rightTitle,
                  fontSize:
                      Responsive.isMobile ? FontSize.large : FontSize.massive,
                  fontColor: AppColors.orange,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: Responsive.isMobile
                      ? kDefaultExThinPadding
                      : kDefaultPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
