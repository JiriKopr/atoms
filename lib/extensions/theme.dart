import 'package:flutter/material.dart';

extension ColorSchemeFromContext on BuildContext {
  /// Simple shorthand to access the [ColorScheme]
  /// from [BuildContext]
  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}

extension ColorExtension on String {
  /// Create [Color] from string which has
  /// HEX format of wanted color
  Color get toColor {
    String hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    assert(hexColor.length == 8);

    return Color(int.parse("0x$hexColor"));
  }
}
