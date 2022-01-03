//import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
/*
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toogleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    // ignore: avoid_print
    print('Segundo : $isOn');
    notifyListeners();
  }
}
*/

const Color kFont = Color(0xFF252435);
const Color kFontLight = Color(0xFFB4B7BF);
const Color kAccent = Color(0xFFFDCA73);
const Color kBackGround = Color(0xFFFCFCFC);
const Color backgroundColor = Color(0xFFECF3F9);
const Color iconColor = Color(0xFFB6C7D1);
const Color activeColor = Color(0xFF09126C);
const Color textColor1 = Color(0XFFA7BCC7);
const Color textColor2 = Color(0XFF9BB3C0);
const Color facebookColor = Color(0xFF3B5999);
const Color googleColor = Color(0xFFDE4B39);
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFffb746);
const Color pinkClr = Color(0xFFff4667);
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = const Color(0xFF424242);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  // ignore: avoid_function_literals_in_foreach_calls
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

// Color(0xFFFFAB91)
//const Color(0xFF0D47A1)
//        const Color(0xff26a69a),
// Color(0xff546e7a),

final box = GetStorage();

class Temas {
  static final light = ThemeData(
      primarySwatch: createMaterialColor(
        const Color(0xff00695c),
      ),

      //
      backgroundColor: Colors.pink,
      //
      dialogBackgroundColor: Colors.white,
      // CheckBox
      toggleableActiveColor: Colors.deepOrange,
      // AppBar em Brightness.dark
      cardColor: Colors.yellow,
      canvasColor: Colors.white,
      focusColor: Colors.green,
      indicatorColor: Colors.yellow,
      hintColor: Colors.white,
      hoverColor: Colors.red,
      splashColor: Colors.yellow,
      selectedRowColor: Colors.yellow,
      highlightColor: Colors.amber,
      secondaryHeaderColor: Colors.yellow,

//      textSelectionHandleColor: ,
//      cursorColor: ,
//      primaryColor: Colors.amber,
//      primaryColorBrightness: Colors.red,
//      accentColor:
//      textSelectionColor: ,
//      textSelectionHandleColor: Temas

      brightness: Brightness.light);

//        visualDensity: VisualDensity.adaptivePlatformDensity,

  static final dark = ThemeData(
      primarySwatch: createMaterialColor(const Color(0xFF212121)),
      brightness: Brightness.dark);
//        visualDensity: VisualDensity.adaptivePlatformDensity,

}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
