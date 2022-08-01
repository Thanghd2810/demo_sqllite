import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/theme.dart';

///
/// [TextView] is a widget that displays text
/// ///
/// use it:
/// ```
/// TextView(
///   'Sample Text',
///   fontColor: FontColor.green,
///   fontSize: FontSize.medium,
///   fontWeight: FontWeight.bold,
/// ),
/// ```
///
/// Select fontColor from [FontColor]
/// Select fontSize from [FontSize]
/// Select fontWeight from [FontWeight]
///
class TextView extends HookWidget {
  const TextView(
    this.text, {
    Key? key,
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.fontColor,
    this.fontDarkColor,
    this.defaultTextStyle,
    this.strutStyle,
    this.overflow,
    this.textAlign,
    this.textDecoration,
    this.maxLines,
  }) : super(key: key);

  final String text;

  final TextOverflow? overflow;

  final int? maxLines;

  /// Specify the default style defined in [Theme].
  /// * However, individual settings have priority.
  final TextStyle? defaultTextStyle;
  final StrutStyle? strutStyle;

  /// Set the font style ([FontFamily], [FontWeight], [FontSize], [FontColor])
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Color? fontDarkColor;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _textStyle(context),
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
      strutStyle: strutStyle,
      maxLines: maxLines,
    );
  }

  TextStyle? _textStyle(BuildContext context) {
    TextStyle? textStyle;

    textStyle = defaultTextStyle ?? Theme.of(context).textTheme.subtitle2;

    return textStyle?.copyWith(
      fontFamily: fontFamily,
      fontSize: fontSize ?? FontSize.large,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: textDecoration,
      color: (Theme.of(context).brightness == Brightness.light)
          ? fontColor ?? FontColor.black
          : fontDarkColor ?? FontColor.white,
    );
  }
}
