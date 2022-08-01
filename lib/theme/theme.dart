library app_theme;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'color.dart';

part 'text.dart';

final kLightThemeData = ThemeData(
  brightness: Brightness.light,
  primarySwatch: AppColors.skyBlue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: AppColors.skyBlue,
  hintColor: Colors.grey,
  dividerTheme: const DividerThemeData(space: 1),
  scaffoldBackgroundColor: AppColors.skyBlue[50],
  primaryTextTheme: const TextTheme(
    subtitle1: TextStyle(
      color: AppColors.skyBlue,
      fontSize: 12,
    ),
  ),
  appBarTheme: _kAppBarTheme.copyWith(
    color: AppColors.skyBlue[50],
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
);

final kDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: AppColors.skyBlue[700],
  scaffoldBackgroundColor: Colors.grey[700],
  toggleableActiveColor: AppColors.skyBlue,
  primaryTextTheme: const TextTheme(
    subtitle1: TextStyle(
      color: AppColors.skyBlue,
      fontSize: 12,
    ),
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppColors.skyBlue[400],
  ),
  appBarTheme: _kAppBarTheme.copyWith(
    color: AppColors.skyBlue[50],
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);

const _kAppBarTheme = AppBarTheme(
  centerTitle: true,
);
