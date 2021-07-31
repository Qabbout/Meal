import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  var primaryColor = Colors.deepPurple;
  var accentColor = Colors.lightGreenAccent;

  var themeMode = ThemeMode.system;

  onChanged(color, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(color.hashCode)
        : accentColor = _toMaterialAccentColor(color.hashCode);
    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFEDE7F6),
        100: Color(0xFFD1C4E9),
        200: Color(0xFFB39DDB),
        300: Color(0xFF9575CD),
        400: Color(0xFF7E57C2),
        500: Color(colorVal),
        600: Color(0xFFC9C1DA),
        700: Color(0xFF512DA8),
        800: Color(0xFF4527A0),
        900: Color(0xFF311B92),
      },
    );
  }

  MaterialAccentColor _toMaterialAccentColor(colorVal) {
    return MaterialAccentColor(
      colorVal,
      <int, Color>{
        100: Color(0xFFCCFF90),
        200: Color(colorVal),
        400: Color(0xFF76FF03),
        700: Color(0xFF64DD17),
      },
    );
  }

  void thmeModeChanged(newThemVal) {
    themeMode = newThemVal;
    notifyListeners();
  }
}
