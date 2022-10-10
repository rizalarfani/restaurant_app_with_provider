import 'package:flutter/material.dart';
import 'colors_theme.dart';

class TypographyStyle {
  static TextTheme ligthTexThme = TextTheme(
    headline4: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: ColorsTheme.primaryTextColor,
    ),
    bodyText1: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 16,
      color: ColorsTheme.primaryColor,
    ),
    bodyText2: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.primaryTextColor,
    ),
    caption: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.secundaryTextColor,
    ),
    subtitle2:  TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.primaryColor,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headline4: const TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    subtitle2: const TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white
    ),
    bodyText1:  TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 16,
      color: ColorsTheme.primaryColor,
    ),
    bodyText2: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.primaryTextColor,
    ),
    caption: TextStyle(
      fontFamily: 'sofiapro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color:  ColorsTheme.secundaryTextColor,
    ),
  );
}
