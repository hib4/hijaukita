import 'dart:ui';

class ColorValues {
  /// Base
  static const Color base01 = Color(0XFFF8FAFE);

  /// Black
  static const Color black01 = Color(0XFF1B1B1B);

  /// Grey
  static const Color grey01 = Color(0XFFF6F6F6);
  static const Color grey02 = Color(0XFFE8E8E8);
  static const Color grey03 = Color(0XFFBDBDBD);
  static const Color grey04 = Color(0XFF666666);

  /// Green
  static const Color green01 = Color(0XFF285430);
  static const Color green02 = Color(0XFF5F8D4E);
  static const Color green03 = Color(0XFFA4BE7B);

  /// Beige
  static const Color beige01 = Color(0XFFF7E1AE);
  static const Color beige02 = Color(0XFFFFF8D6);
  static const Color beige03 = Color(0XFFE5D9B6);

  /// Blue
  static const Color blue01 = Color(0XFF7BA2BE);

  /// Gradient
  static const List<Color> gradient01 = [
    Color(0XFF285430),
    Color(0XFFC9FF85),
  ];
  static const List<Color> gradient02 = [
    Color(0XFFFF8484),
    Color(0XFFFFE1E1),
  ];
  static const List<Color> gradient03 = [
    Color(0XFF0080BF),
    Color(0XFFCCF9FF),
  ];

  /// Sub
  static Color subPink = const Color(0XFFFFE1E1).withOpacity(0.2);
  static Color subGreen = const Color(0XFFC9FF85).withOpacity(0.2);
  static Color subBlue = const Color(0XFFCCF9FF).withOpacity(0.2);
}
