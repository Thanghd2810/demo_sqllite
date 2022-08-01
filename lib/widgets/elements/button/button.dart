library sakura_button;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/const/constants.dart';
import '../../../theme/theme.dart';
import '../lazy_future_builder.dart';
import '../loading/indicator.dart';

part 'loading_button.dart';

/// ///
/// [Button] is a button widget
/// ///
/// use it:
/// ```
/// Button (
///   "Button title",
///   onPressed: () {
///   print ("Click");
///   },
/// )
/// ```
/// ///
/// NOTE: Created based on the style guide
/// ///

///
/// The button type is defined as [ButtonType].
/// NOTE: If the current [Button Type] is not enough,
/// Add [ButtonType].
///
enum ButtonType {
  primary,
  primaryLight,
  accent,
  white,
}

///
/// Defines the background color of [ButtonType].
///
extension ButtonTypeBackground on ButtonType {
  Color? background(ThemeData themeData, {bool enabled = true}) {
    final isLightTheme = themeData.brightness == Brightness.light;

    if (enabled == false) {
      switch (this) {
        case ButtonType.accent:
        case ButtonType.white:
          if (isLightTheme) {
            return Colors.grey[300]!;
          } else {
            return Colors.grey[800]!;
          }

        case ButtonType.primary:
        case ButtonType.primaryLight:
          return themeData.scaffoldBackgroundColor;

        default:
      }

      throw Exception('Do not find ButtonType');
    }

    switch (this) {
      case ButtonType.primary:
        return themeData.primaryColor;

      case ButtonType.primaryLight:
        return AppColors.skyBlue[50];

      case ButtonType.accent:
        return null;

      case ButtonType.white:
        return AppColors.white;

      default:
    }

    throw Exception('Do not find ButtonType');
  }
}

///
/// Defines the text color of [ButtonType].
///
extension ButtonTypeTextColor on ButtonType {
  Color textColor(ThemeData themeData, {bool enabled = true}) {
    final isLightTheme = themeData.brightness == Brightness.light;

    if (enabled == false) {
      switch (this) {
        case ButtonType.primary:
        case ButtonType.primaryLight:
        case ButtonType.white:
          return AppColors.white;

        case ButtonType.accent:
          if (isLightTheme) {
            return Colors.grey[400]!;
          } else {
            return Colors.grey[700]!;
          }

        default:
      }
    }

    switch (this) {
      case ButtonType.primary:
        return AppColors.white;

      case ButtonType.primaryLight:
        return AppColors.skyBlue;

      case ButtonType.accent:
      case ButtonType.white:
        return themeData.primaryColor;

      default:
    }

    throw Exception('Do not find ButtonType');
  }
}

///
/// It defines the border line of [ButtonType].
///
extension ButtonTypeBorderColor on ButtonType {
  Color borderColor(ThemeData themeData, {bool enabled = true}) {
    final isLightTheme = themeData.brightness == Brightness.light;

    if (enabled == false) {
      switch (this) {
        case ButtonType.primary:
        case ButtonType.primaryLight:
        case ButtonType.white:
          if (isLightTheme) {
            return Colors.grey[300]!;
          } else {
            return Colors.grey[800]!;
          }

        case ButtonType.accent:
          if (isLightTheme) {
            return Colors.grey[400]!;
          } else {
            return Colors.grey[700]!;
          }

        default:
      }
    }

    switch (this) {
      case ButtonType.primary:
      case ButtonType.accent:
        return themeData.primaryColor;

      case ButtonType.primaryLight:
        return AppColors.skyBlue[50]!;

      case ButtonType.white:
        if (isLightTheme) {
          return AppColors.white;
        } else {
          return AppColors.white;
        }

      default:
    }

    throw Exception('Do not find ButtonType');
  }
}

///
/// [ButtonType] defines the indicator color used in [Loading Button].
///
extension ButtonTypeIndicatorColor on ButtonType {
  IndicatorColor indicatorColor(ThemeData themeData) {
    final isLightTheme = themeData.brightness == Brightness.light;

    switch (this) {
      case ButtonType.primary:
        return IndicatorColor.white;

      case ButtonType.primaryLight:
        return IndicatorColor.black;

      case ButtonType.accent:
        if (isLightTheme) {
          return IndicatorColor.black;
        } else {
          return IndicatorColor.white;
        }

      case ButtonType.white:
        return IndicatorColor.black;

      default:
    }

    throw Exception('Do not find ButtonType');
  }
}

///
/// Define the button size as [ButtonSize]
///
enum ButtonSize {
  medium,
  large,
  infinityWith,
}

///
/// Define the height of the button for each [ButtonSize]
///
extension ButtonSizeHeigh on ButtonSize {
  double get height {
    switch (this) {
      case ButtonSize.medium:
        return 40.0;

      case ButtonSize.large:
        return 48.0;

      case ButtonSize.infinityWith:
        return 48.0;

      default:
    }
    throw Exception('Do not find ButtonSize');
  }
}

///
/// Define the width of the button for each [ButtonSize]
///
extension ButtonSizeWidth on ButtonSize {
  double get width {
    switch (this) {
      case ButtonSize.medium:
        return 120.0;

      case ButtonSize.large:
        return 160.0;

      case ButtonSize.infinityWith:
        return double.infinity;

      default:
    }
    throw Exception('Do not find ButtonSize');
  }
}

///
/// Define the border radius of the button for each [ButtonSize]
///
extension ButtonSizeBorderRadius on ButtonSize {
  double get radius {
    switch (this) {
      case ButtonSize.medium:
        return 20;

      case ButtonSize.large:
        return 24;

      case ButtonSize.infinityWith:
        return 24;

      default:
    }
    throw Exception('Do not find ButtonSize');
  }
}

///
/// Define the font style of the button for each [ButtonSize]
///
extension ButtonSizeFontStyle on ButtonSize {
  double get fontSize {
    switch (this) {
      case ButtonSize.medium:
        return 14;

      case ButtonSize.large:
        return 16;

      case ButtonSize.infinityWith:
        return 16;

      default:
    }
    throw Exception('Do not find ButtonSize');
  }
}

///
/// Define the font style of the button for each [ButtonSize]
///
extension ButtonSizeIndicator on ButtonSize {
  double get indicatorSize {
    switch (this) {
      case ButtonSize.medium:
        return 12;

      case ButtonSize.large:
        return 14;

      case ButtonSize.infinityWith:
        return 14;

      default:
    }

    throw Exception('Do not find ButtonSize');
  }
}

class Button extends HookWidget {
  const Button(
    this.title, {
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.buttonType = ButtonType.primary,
    this.buttonSize = ButtonSize.medium,
    this.enabled = true,
    this.child,
    this.padding,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  final ButtonType buttonType;
  final ButtonSize buttonSize;

  final bool enabled;
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final button = OutlinedButton(
      style: _getButtonStyle(themeData),
      onPressed: onPressed,
      onLongPress: (onLongPress != null) ? onLongPress : null,
      child: (child != null) ? child! : childText(themeData),
    );

    return button;
  }

  ButtonStyle _getButtonStyle(ThemeData themeData) {
    return OutlinedButton.styleFrom(
      backgroundColor: buttonType.background(themeData, enabled: enabled),
      primary: buttonType.textColor(themeData, enabled: enabled),
      minimumSize: Size(buttonSize.width, buttonSize.height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonSize.radius),
      ),
      side: BorderSide(
        color: buttonType.borderColor(themeData, enabled: enabled),
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
    );
  }

  Widget childText(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Text(
        title,
        style: themeData.textTheme.subtitle1!.copyWith(
          color: buttonType.textColor(themeData, enabled: enabled),
          fontSize: buttonSize.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
