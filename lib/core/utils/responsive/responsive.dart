part of utils;

enum DeviceType { mobile, tablet }

extension ResponsiveUtilExtension on num {
  /// Get height amount to percentage of screen's height
  ///
  /// Eg: 10.h -> will take 10% of the screen's height
  double get h => this * Responsive.height / 100;

  /// Get height amount to percentage of screen's width
  ///
  /// Eg: 10.w -> will take 10% of the screen's width
  double get w => this * Responsive.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (Responsive.width / 3) / 100;
}

class Responsive {
  Responsive._();

  static Responsive? _instance;

  factory Responsive() => _instance ??= Responsive._();

  /// Device BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device Orientation
  static late Orientation orientation;

  /// Type of Device
  static late DeviceType deviceType;

  /// Device Height
  static late double height;

  /// Device Width
  static late double width;

  /// Set the Screen size and Device Orientation,
  /// BoxConstraints, Height, and Width
  static void setResponsive(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    // Set boxConstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Set screen width and height
    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    // Set ScreenType
    if ((orientation == Orientation.portrait && width < 600) ||
        (orientation == Orientation.landscape && height < 600)) {
      deviceType = DeviceType.mobile;
    } else {
      deviceType = DeviceType.tablet;
    }
  }

  /// Returns [true] if the app runs on a phone,
  /// [false] if the app runs on a tablet
  static bool get isMobile => deviceType == DeviceType.mobile;

  /// Returns [true] if the app runs on a tablet,
  /// [false] if the app runs on a phone
  static bool get isTablet => deviceType == DeviceType.tablet;
}
