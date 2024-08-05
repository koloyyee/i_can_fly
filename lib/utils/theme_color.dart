/// This file contains the color constants used in the app.
/// The colors are used to maintain a consistent color scheme
/// throughout the app.
/// 
/// The colors are defined as an enum with a color value.
/// The color value is an integer value that represents the color
/// in hexadecimal format.
/// 
/// usage:
/// ```dart
/// import 'package:i_can_fly/utils/theme_color.dart';
/// e.g: CTColor.Green.Lime // returns 0xffE5FCC2
/// ``` 
enum CTColor {
  Lime(0xffE5FCC2),
  Green(0xff9DE0AD),
  Teal(0xff45ADA8),
  DarkTeal(0xff2E8B57),
  LightTeal(0xffd8ebe9),
  BlackTeal(0xff012E40);

  final int colorValue;
  const CTColor(this.colorValue);
}