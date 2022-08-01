import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './text_area.dart';
import '../../../../core/const/constants.dart';
import '../../../theme/theme.dart';

///
/// Added a function to hide the input contents in [TextArea]
///
class ObscureTextArea extends HookWidget {
  const ObscureTextArea({
    Key? key,
    this.labelText,
    this.hintText,
    this.onSaved,
    this.focusNode,
    this.textInputAction,
    this.isRequired = false,
    this.textType = TextType.text,
    this.autofillHints,
    this.prefixIcon,
    this.textLightColor,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.borderRadius,
    this.filled = false,
    this.fillColor,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;

  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  final bool isRequired;
  final TextType textType;
  final Widget? prefixIcon;

  final Color? textLightColor;
  final FloatingLabelBehavior floatingLabelBehavior;
  final double? borderRadius;
  final bool filled;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final showObscure = useState<bool>(false);

    return TextArea(
      obscureText: !showObscure.value,
      textInputAction: textInputAction,
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      floatingLabelBehavior: floatingLabelBehavior,
      textLightColor: textLightColor,
      borderRadius: borderRadius,
      filled: filled,
      fillColor: fillColor,
      suffixIcon: InkWell(
        onTap: () => showObscure.value = !showObscure.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Icon(
            showObscure.value
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
            color: AppColors.skyBlue,
            size: kWideIconSize,
          ),
        ),
      ),
      onSaved: onSaved,
      focusNode: focusNode,
      isRequired: isRequired,
      enabled: true,
      textAreaType: TextAreaType.normal,
      autofillHints: autofillHints,
    );
  }
}
