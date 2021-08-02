import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  var primaryColor = Colors.deepPurple;
  var accentColor = Colors.lightGreenAccent;

  var themeMode = ThemeMode.system;
  String themeText = 's';

  onChanged(color, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(color.hashCode)
        : accentColor = _toMaterialAccentColor(color.hashCode);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  resetThemeToDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primaryColor = Colors.deepPurple;
    prefs.setInt("primaryColor", Colors.deepPurple.value);
    accentColor = Colors.lightGreenAccent;
    prefs.setInt("accentColor", Colors.lightGreenAccent.value);
    notifyListeners();
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primaryColor = _toMaterialColor(prefs.getInt("primaryColor") ?? 0xFF673AB7);
    accentColor =
        _toMaterialAccentColor(prefs.getInt("accentColor") ?? 0xFFB2FF59);
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

  void themeModeChanged(newThemVal) async {
    themeMode = newThemVal;
    _getThemeText(themeMode);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark)
      themeText = 'd';
    else if (themeMode == ThemeMode.light)
      themeText = 'l';
    else
      themeText = 's';
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";
    if (themeText == 'd')
      themeMode = ThemeMode.dark;
    else if (themeText == 'l')
      themeMode = ThemeMode.light;
    else
      themeMode = ThemeMode.system;
    notifyListeners();
  }
}
