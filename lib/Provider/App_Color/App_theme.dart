import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/Screens/Home_Screen.dart';
import 'package:note_app/Provider/App_Color/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool IsLightTheme;
  ThemeProvider({required this.IsLightTheme});

  tooggleThemeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (IsLightTheme) {
      sharedPreferences.setBool(spref_key.isLight, false);
      IsLightTheme = !IsLightTheme;
      notifyListeners();
    } else {
      sharedPreferences.setBool(spref_key.isLight, true);
      IsLightTheme = !IsLightTheme;
      notifyListeners();
    }
  }

  Headline_Color() {
    if (IsLightTheme) {
      return App_colors.dark_black;
    } else {
      return App_colors.white;
    }
  }

  Inside_Text_color() {
    if (IsLightTheme) {
      return App_colors.white;
    } else {
      return App_colors.dark_black;
    }
  }

  ThemeData themeData() {
    return ThemeData(
        scaffoldBackgroundColor:
            IsLightTheme ? App_colors.white : Color.fromARGB(255, 32, 30, 30));
  }

  List<Color> light_md_cl = const [
    Color.fromARGB(255, 242, 204, 79),
    Color.fromARGB(255, 238, 156, 34)
  ];

  List<Color> dark_md_cl = const [
    Color.fromARGB(255, 255, 17, 92),
    Color.fromARGB(255, 255, 0, 38)
  ];

  Theme_note() {
    if (IsLightTheme) {
      return light_md_cl;
    } else {
      return dark_md_cl;
    }
  }

  Icon_color() {
    if (IsLightTheme) {
      return Color.fromARGB(255, 22, 22, 22);
    } else {
      return App_colors.white;
    }
  }

  navIconcolorSelected() {
    if (IsLightTheme) {
      return Color.fromARGB(255, 31, 31, 31);
    } else {
      return Color.fromARGB(255, 222, 222, 222);
    }
  }

  navIconcolorUnselected() {
    if (IsLightTheme) {
      return Color.fromARGB(255, 188, 187, 187);
    } else {
      return Color.fromARGB(255, 129, 128, 128);
    }
  }

  navBarShapeColor() {
    if (IsLightTheme) {
      return Color.fromARGB(255, 234, 234, 234);
    } else {
      return Color.fromARGB(255, 47, 47, 47);
    }
  }
}
