import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/colors_theme.dart';
import 'package:restaurant_app/utils/typography_style.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: ColorsTheme.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TypographyStyle.ligthTexThme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TypographyStyle.darkTextTheme,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromRGBO(9, 25, 69, 1),
  );
}
