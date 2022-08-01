import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:validators/validators.dart';

import '../../../../core/const/constants.dart';
import '../../../theme/theme.dart';

enum TextType {
  text,
  password,
  email,
  number,
}

/// Maximum number of strings
const int _kStringMaxLength = 255;

///
/// [TextType] Defines validation of things.
/// NOTE: If the current [TextType] is not enough,
/// Consider adding [TextType] first.
///
extension TextTypeValidate on TextType {
  String? validate(String value) {
    switch (this) {
      case TextType.text:
        if (!isLength(value, 1, _kStringMaxLength)) {
          return "Vui lòng nhập ít hơn 255 ký tự";
        }
        break;

      case TextType.password:
        if (!isAlphanumeric(value)) {
          return "Mật khẩu không đúng định dạng";
        }
        if (!isLength(value, 1, _kStringMaxLength)) {
          return "Vui lòng nhập ít hơn 255 ký tự";
        }
        break;

      case TextType.email:
        if (!isEmail(value)) {
          return "Email không đúng định dạng";
        }
        if (!isLength(value, 1, _kStringMaxLength)) {
          return "Vui lòng nhập ít hơn 255 ký tự";
        }
        break;

      case TextType.number:
        if (!isNumeric(value)) {
          return "không đúng định dạng";
        }
        if (!isLength(value, 1, _kStringMaxLength)) {
          return "Vui lòng nhập ít hơn 255 ký tự";
        }
        break;

      default:
    }
    return null;
  }
}

///
/// [TextType] Defines the keyboard type of things.
/// NOTE: If the current [TextType] is not enough,
/// Consider adding [TextType] first.
///
extension TextTypeKeyboardType on TextType {
  TextInputType get keyboardType {
    switch (this) {
      case TextType.password:
        return TextInputType.visiblePassword;

      case TextType.email:
        return TextInputType.emailAddress;

      case TextType.number:
        return TextInputType.number;

      default:
    }
    return TextInputType.text;
  }
}

enum TextAreaType {
  /// The height of the [TextArea] is 52px.
  normal,

  /// The height of the [TextArea] is 40px.
  ///
  /// However, if there is an icon in the form, the height may change.
  thin,
}

/// Defines the height of [TextAreaType].
///
/// NOTE: The actual height is determined by the padding from [hintText()].
///
extension TextAreaTypeHeight on TextAreaType {
  double get height {
    switch (this) {
      case TextAreaType.normal:
        return 52;

      case TextAreaType.thin:
        return 40;

      default:
        throw Exception('Do not find TextAreaType');
    }
  }
}

/// Defines the border radius of [TextAreaType].
///
extension TextAreaTypeBorderRadius on TextAreaType {
  BorderRadius get borderRadius {
    switch (this) {
      case TextAreaType.normal:
        return BorderRadius.circular(15);

      case TextAreaType.thin:
        return BorderRadius.circular(5);

      default:
        throw Exception('Do not find TextAreaType');
    }
  }
}

/// [TextArea] provides a writable widget
///
/// use it:
/// ```
/// TextArea(
///   textType: TextType.text,
///   labelText: 'Please fill in your name',
///   hintText: 'Jon..',
///   onSaved: (value) {
///
///   },
/// ),
/// ```
class TextArea extends HookWidget {
  const TextArea({
    Key? key,
    this.labelText,
    this.hintText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.onTap,
    this.suffixIcon,
    this.suffixText,
    this.prefixIcon,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction,
    this.obscureText = false,
    this.isRequired = false,
    this.textType = TextType.text,
    this.textAlign = TextAlign.start,
    this.value,
    this.enabled = true,
    this.textAreaType = TextAreaType.normal,
    this.readOnly = false,
    this.autoValidate = false,
    this.textInputType,
    this.autofillHints,
    this.fontSize = 16,
    this.fontWeight,
    this.isGlassMorphismStyle = false,
    this.textLightColor,
    this.textDarkColor,
    this.borderRadius,
    this.filled = false,
    this.fillColor,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final FloatingLabelBehavior floatingLabelBehavior;

  final GestureTapCallback? onTap;

  /// If [suffixIcon] is specified,
  /// it will be placed at the right end of [TextArea].
  final Widget? suffixIcon;

  final String? suffixText;
   final TextInputType? textInputType;
  /// If [prefixIcon] is specified,
  /// it will be placed at the left end of [TextArea].
  final Widget? prefixIcon;

  /// [onSaved] is called when save () is executed in [Form]
  ///
  /// see also: [Form]
  /// https://api.flutter.dev/flutter/widgets/Form-class.html
  final FormFieldSetter<String>? onSaved;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  /// Because it is UI / UX, it is good to specify [textInputAction]
  /// The Done button on the keyboard changes to "Run / Search / Line feed" etc.
  final TextInputAction? textInputAction;

  final FocusNode? focusNode;
  final bool autofocus;
  final int maxLines;
  final int minLines;

  /// Set to true if you want to display in "******" etc.
  final bool obscureText;

  /// If it is a required input item, please set it to true
  final bool isRequired;

  /// By specifying [TextType],
  /// Validation, keyboard type, formatter, etc. are automatically selected.
  final TextType textType;

  final TextAlign textAlign;

  /// [value] can be used when you want to specify
  ///  the initial value or change the value.
  /// NOTE: If you want to change the value, redraw it.
  /// (Use provider, setState (), etc.)
  final String? value;

  /// If you want to disable [TextArea], set it to `false`.
  final bool enabled;

  /// When [TextArea] is disabled
  /// Set to `true` if you want the layout to be read-only mode only.
  final bool readOnly;

  /// You can change the form type by changing [textAreaType].
  final TextAreaType textAreaType;

  /// Set to `true` for automatic validation.
  final bool autoValidate;

  /// Auto-input settings (may not work properly: verification required)
  final Iterable<String>? autofillHints;

  /// Set the font style ([fontWeight], [fontSize])
  final FontWeight? fontWeight;
  final double fontSize;

  /// Theme
  final bool isGlassMorphismStyle;
  final Color? textLightColor;
  final Color? textDarkColor;
  final double? borderRadius;
  final bool filled;
  final Color? fillColor;

  ///
  /// Update `TextEditingValue`
  ///
  void _initTextEditingValue(TextEditingController controller) {
    final textEditingValue = TextEditingValue(
      text: value ?? '',
      selection: TextSelection.collapsed(
        offset: value?.length ?? 0,
      ),
    );

    controller.value = textEditingValue;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useEffect(
      () {
        _initTextEditingValue(controller);
        return;
      },
      [value, enabled],
    );

    final ThemeData themeData = Theme.of(context);

    final textFormField = TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      textInputAction: textInputAction,

      validator: _validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      textAlign: textAlign,
      enabled: enabled,
      autofocus: autofocus,
      cursorColor: AppColors.black,
      keyboardType: textType.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: _getEffectiveDecoration(themeData),
      style: _getBrightnessTextStyle(themeData).copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      autofillHints: autofillHints,
    );

    return Theme(
      data: _getBrightnessThemeData(themeData),
      child: textFormField,
    );
  }

  /// Define the [TextArea] decoration in [InputDecoration].
  ///
  /// If you change the layout, please change `const/theme.dart`.
  ///
  InputDecoration _getEffectiveDecoration(ThemeData themeData) {
    final InputDecoration textTypeDecoration =
        _getTextTypeDecoration(themeData);

    final InputDecoration effectiveDecoration = textTypeDecoration.copyWith(
      filled: filled,
      fillColor: fillColor,
      labelText: labelText ?? '',
      labelStyle: const TextStyle().copyWith(fontSize: fontSize),
      hintText: hintText ?? '',
      hintStyle: const TextStyle().copyWith(fontSize: fontSize),
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      prefixIcon: prefixIcon,
      floatingLabelBehavior:
          enabled ? floatingLabelBehavior : FloatingLabelBehavior.always,
      prefixIconConstraints: BoxConstraints(
        maxHeight: textAreaType.height,
      ),
      suffixIconConstraints: BoxConstraints(
        maxHeight: textAreaType.height,
      ),
      border: _getBorder(),
      enabledBorder: _getBorder(),
      focusedBorder: _getBorder(),
      disabledBorder: _getBrightnessDisabledBorder(themeData),
    );

    return effectiveDecoration;
  }

  /// Change the layout using [InputDecoration] for each [TextType].
  ///
  InputDecoration _getTextTypeDecoration(ThemeData themeData) {
    final InputDecoration textTypeDecoration =
        const InputDecoration().applyDefaults(themeData.inputDecorationTheme);

    /// [TextAreaType.normal]
    if (textAreaType == TextAreaType.normal) {
      /// HACK:
      /// ///
      /// To set the height of the style guide to 52px
      /// Fixed the problem that the layout is broken when `hintText` is` null`.
      /// ///
      if (hintText?.isNotEmpty ?? true) {
        return textTypeDecoration.copyWith(
          contentPadding: const EdgeInsets.symmetric(
            // TextArea horizontal padding is 16px
            horizontal: kDefaultPadding,

            // TextArea height is 52px : Text(18px) + Padding(19px)
            vertical: kDefaultPadding + 1,
          ),
        );
      }

      return textTypeDecoration;
    }

    /// [TextAreaType.thin]
    else if (textAreaType == TextAreaType.thin) {
      return textTypeDecoration.copyWith(
        contentPadding: const EdgeInsets.symmetric(
          // TextArea horizontal padding is 16px
          horizontal: kDefaultPadding,

          // TextArea height is 40px : Text(20px) + Padding(13px)
          vertical: 10,
        ),
      );
    }

    /// apart from
    else {
      throw Exception('Do not find TextAreaType');
    }
  }

  /// Define the [TextArea] TextStyle.
  ///
  TextStyle _getBrightnessTextStyle(ThemeData themeData) {
    final bool isLightTheme = themeData.brightness == Brightness.light;

    if (textLightColor != null && isLightTheme) {
      return TextStyle(color: textLightColor);
    }

    if (textDarkColor != null && !isLightTheme) {
      return TextStyle(color: textDarkColor);
    }

    return isLightTheme
        ? const TextStyle(
            color: AppColors.black,
          )
        : const TextStyle(
            color: AppColors.white,
          );
  }

  /// Define the [TextArea] border, enabledBorder, focusedBorder.
  ///
  InputBorder? _getBorder() {
    return OutlineInputBorder(
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius!)
          : textAreaType.borderRadius,
      borderSide: BorderSide(
        color: (filled && fillColor != null) ? fillColor! : AppColors.skyBlue,
      ),
    );
  }

  /// Define the [TextArea] `readOnly` disabledBorder.
  ///
  InputBorder? _getBrightnessDisabledBorder(ThemeData themeData) {
    if (!readOnly || enabled) return null;

    return themeData.brightness == Brightness.light
        ? OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.0),
          )
        : OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]!, width: 1.0),
          );
  }

  /// Define the [TextArea] ThemeData.
  ///
  ThemeData _getBrightnessThemeData(ThemeData themeData) {
    return themeData.brightness == Brightness.light
        ? themeData.copyWith(
            /// HACK:
            /// ///
            /// To realize the ReadOnly mode of the style guide,
            /// Forcibly change [disabledColor] when readOnly is `true`
            /// ///
            /// The border color when disabled is specified by `theme.dart`
            /// ///
            disabledColor: (readOnly && !enabled) ? Colors.grey[700] : null,
          )
        : themeData.copyWith(
            /// HACK:
            /// ///
            /// To realize the ReadOnly mode of the style guide,
            /// Forcibly change [disabledColor] when readOnly is `true`
            /// ///
            /// The border color when disabled is specified by `theme.dart`
            /// ///
            disabledColor: (readOnly && !enabled) ? Colors.grey[200] : null,
          );
  }

  String? _validator(String? value) {
    if (value == null) {
      return null;
    }

    if (isRequired) {
      if (value.isEmpty) {
        return "Bắt buộc";
      }
    }

    if (value.isNotEmpty) {
      return textType.validate(value);
    }

    return null;
  }
}
