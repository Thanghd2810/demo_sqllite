// NOTE: To create an original color panel,
//specify the base color at the following site.
// http://mcg.mbitson.com

part of app_theme;

class AppColors {
  AppColors._();

  static const MaterialColor skyBlue = MaterialColor(
    _skyBluePrimaryValue,
    <int, Color>{
      50: Color(0xFFF1F9FD),
      100: Color(0xFFDBF0F9),
      200: Color(0xFFC3E7F5),
      300: Color(0xFFABDDF1),
      400: Color(0xFF99D5EE),
      500: Color(_skyBluePrimaryValue),
      600: Color(0xFF7FC9E9),
      700: Color(0xFF74C2E5),
      800: Color(0xFF6ABCE2),
      900: Color(0xFF57B0DD),
    },
  );
  static const int _skyBluePrimaryValue = 0xFF87CEEB;

  static const MaterialColor skyBlueAccent = MaterialColor(
    _skyBlueAccent,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(_skyBlueAccent),
      400: Color(0xFFDAF2FF),
      700: Color(0xFFC1EAFF),
    },
  );

  static const int _skyBlueAccent = 0xFFFFFFFF;

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  static const Color pink = Color(0xFFeab9bc);

  static const Color grey = Color(0xFF9E9E9E);

  static const Color red = Color(0xFFDB2424);

  static const Color orange = Color(0xFFFF6500);

  static const Color green = Color(0xFF4CAF50);
}
