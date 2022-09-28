import 'package:flutter/material.dart';

import '../../storage/my_shared_pref.dart';
import '../translations/localization_service.dart';

class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType =>
      LocalizationService.supportedLanguagesFontsFamilies[MySharedPref.getCurrentLocal().languageCode]!;

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => 18;

  // body font size
  static double get body1TextSize => 16;
  static double get body2TextSize => 16;

  static double get bodyLarge => 16;
  static double get bodySmall => 10;

  // headlines font size
  static double get headline1TextSize => 90;
  static double get headline2TextSize => 70;
  static double get headline3TextSize => 50;
  static double get headline4TextSize => 40;
  static double get headline5TextSize => 30;
  static double get headline6TextSize => 25;

  //button font size
  static double get buttonTextSize => 16;

  //caption font size
  static double get captionTextSize => 13;

  //chip font size
  static double get chipTextSize => bodyLarge;
}
