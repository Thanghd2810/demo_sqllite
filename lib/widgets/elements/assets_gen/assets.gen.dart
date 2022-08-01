/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/RobotoSlab-Medium.ttf
  String get robotoSlabMedium => 'assets/fonts/RobotoSlab-Medium.ttf';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_beyond_meat_mcdonalds.png
  AssetGenImage get icBeyondMeatMcdonalds =>
      const AssetGenImage('assets/images/ic_beyond_meat_mcdonalds.png');

  /// File path: assets/images/ic_burger.png
  AssetGenImage get icBurger =>
      const AssetGenImage('assets/images/ic_burger.png');

  /// File path: assets/images/ic_diet.png
  AssetGenImage get icDiet => const AssetGenImage('assets/images/ic_diet.png');

  /// File path: assets/images/ic_diet_gray.png
  AssetGenImage get icDietGray =>
      const AssetGenImage('assets/images/ic_diet_gray.png');

  /// File path: assets/images/ic_edit.png
  AssetGenImage get icEdit => const AssetGenImage('assets/images/ic_edit.png');

  /// File path: assets/images/ic_insurance.png
  AssetGenImage get icInsurance =>
      const AssetGenImage('assets/images/ic_insurance.png');

  /// File path: assets/images/ic_insurance_gray.png
  AssetGenImage get icInsuranceGray =>
      const AssetGenImage('assets/images/ic_insurance_gray.png');

  /// File path: assets/images/ic_logo_react.png
  AssetGenImage get icLogoReact =>
      const AssetGenImage('assets/images/ic_logo_react.png');

  /// File path: assets/images/ic_printer.png
  AssetGenImage get icPrinter =>
      const AssetGenImage('assets/images/ic_printer.png');

  /// File path: assets/images/ic_trash.png
  AssetGenImage get icTrash =>
      const AssetGenImage('assets/images/ic_trash.png');

  /// File path: assets/images/ic_trash_order.png
  AssetGenImage get icTrashOrder =>
      const AssetGenImage('assets/images/ic_trash_order.png');

  /// File path: assets/images/ic_trolley.png
  AssetGenImage get icTrolley =>
      const AssetGenImage('assets/images/ic_trolley.png');

  /// File path: assets/images/ic_trolley_gray.png
  AssetGenImage get icTrolleyGray =>
      const AssetGenImage('assets/images/ic_trolley_gray.png');
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_bag.svg
  SvgGenImage get icBag => const SvgGenImage('assets/svgs/ic_bag.svg');

  /// File path: assets/svgs/ic_burger_beer.svg
  SvgGenImage get icBurgerBeer =>
      const SvgGenImage('assets/svgs/ic_burger_beer.svg');

  /// File path: assets/svgs/ic_chinese_noodles.svg
  SvgGenImage get icChineseNoodles =>
      const SvgGenImage('assets/svgs/ic_chinese_noodles.svg');

  /// File path: assets/svgs/ic_following.svg
  SvgGenImage get icFollowing =>
      const SvgGenImage('assets/svgs/ic_following.svg');

  /// File path: assets/svgs/ic_gyph.svg
  SvgGenImage get icGyph => const SvgGenImage('assets/svgs/ic_gyph.svg');

  /// File path: assets/svgs/ic_home.svg
  SvgGenImage get icHome => const SvgGenImage('assets/svgs/ic_home.svg');

  /// File path: assets/svgs/ic_macdonalds.svg
  SvgGenImage get icMacdonalds =>
      const SvgGenImage('assets/svgs/ic_macdonalds.svg');

  /// File path: assets/svgs/ic_menu.svg
  SvgGenImage get icMenu => const SvgGenImage('assets/svgs/ic_menu.svg');

  /// File path: assets/svgs/ic_more.svg
  SvgGenImage get icMore => const SvgGenImage('assets/svgs/ic_more.svg');

  /// File path: assets/svgs/ic_notification.svg
  SvgGenImage get icNotification =>
      const SvgGenImage('assets/svgs/ic_notification.svg');

  /// File path: assets/svgs/ic_person.svg
  SvgGenImage get icPerson => const SvgGenImage('assets/svgs/ic_person.svg');

  /// File path: assets/svgs/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/svgs/ic_search.svg');

  /// File path: assets/svgs/ic_share.svg
  SvgGenImage get icShare => const SvgGenImage('assets/svgs/ic_share.svg');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
