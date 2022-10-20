import 'package:flutter/material.dart';

import 'light_theme_colors.dart';
import 'my_styles.dart';

// ignore_for_file: deprecated_member_use

class MyTheme {
  static getThemeData() {
    return ThemeData(
      // main color (app bar,tabs..etc)
      colorScheme: const ColorScheme.light().copyWith(
        primary: myBlack,
      ),

      primaryColor: LightThemeColors.primaryColor, // secondary color (for checkbox,float button, radio..etc)
      accentColor: LightThemeColors.accentColor,
      // color contrast (if the theme is dark text should be white for example)
      brightness: Brightness.light,
      // card widget background color
      cardColor: LightThemeColors.cardColor,
      // hint text color
      hintColor: LightThemeColors.hintTextColor,
      // divider color
      dividerColor: LightThemeColors.dividerColor,
      // app background color
      backgroundColor: LightThemeColors.backgroundColor,
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: LightThemeColors.primaryColor),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(),

      // elevated button theme
      elevatedButtonTheme: MyStyles.getElevatedButtonTheme(),

      // text theme
      textTheme: MyStyles.getTextTheme(),

      // chip theme
      chipTheme: MyStyles.getChipTheme(),

      // icon theme
      iconTheme: MyStyles.getIconTheme(),

      //divider
      dividerTheme: MyStyles.getDividerTheme(),

      radioTheme: MyStyles.getRadioButtonTheme(),

      cardTheme: MyStyles.getCardTheme(),

      // textField theme
      // inputDecorationTheme: MyStyles.getInputDecorationTheme(Theme: ),

      //dialog
      dialogTheme: MyStyles.getDialogTheme(),

      //drawer (my custom menu)
      drawerTheme: MyStyles.getDrawerThemeData(),
    );
  }
}
