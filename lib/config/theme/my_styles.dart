import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  ///icons theme
  static IconThemeData getIconTheme() => const IconThemeData(color: LightThemeColors.iconColor);
  static TabBarTheme getTabBarTheme() => const TabBarTheme(
        indicator: BoxDecoration(color: LightThemeColors.primaryColor),
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme() => AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      elevation: 0,
      titleTextStyle: getTextTheme().bodyText1!.copyWith(
            color: Colors.white,
            fontSize: MyFonts.appBarTittleSize,
          ),
      iconTheme: const IconThemeData(color: LightThemeColors.appBarIconsColor),
      backgroundColor: LightThemeColors.appBarColor);

  ///text theme
  static TextTheme getTextTheme() => TextTheme(
        button: MyFonts.buttonTextStyle.copyWith(fontSize: MyFonts.buttonTextSize),
        //
        bodyText1: (MyFonts.bodyTextStyle).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: MyFonts.body1TextSize,
            color: LightThemeColors.bodyTextColor),
        //
        bodyText2: (MyFonts.bodyTextStyle)
            .copyWith(fontSize: MyFonts.body2TextSize, color: LightThemeColors.bodyTextColor),
        //
        headline1: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline1TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline2: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline2TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline3: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline3TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline4: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline4TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline5: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline5TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline6: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline6TextSize,
            fontWeight: FontWeight.w700,
            color: LightThemeColors.headlinesTextColor),
        caption: TextStyle(color: LightThemeColors.captionTextColor, fontSize: MyFonts.captionTextSize),
      );

  // Chip theme
  static ChipThemeData getChipTheme() {
    return ChipThemeData(
      backgroundColor: LightThemeColors.chipBackground,
      brightness: Brightness.light,
      labelStyle: getChipTextStyle(),
      secondaryLabelStyle: getChipTextStyle().copyWith(color: Colors.white),
      selectedColor: myBlack,
      disabledColor: Colors.white,
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        side: BorderSide(
          color: myBlack,
          width: 1.5.sp,
        ),
      ),
    );
  }

  //Drawer Theme (I use this theme for my custom menu)
  static DrawerThemeData getDrawerThemeData() => const DrawerThemeData(
        backgroundColor: LightThemeColors.menuColor,
        width: 200,
      );

  ///Chips text style
  static TextStyle getChipTextStyle() {
    return MyFonts.chipTextStyle.copyWith(
      fontSize: MyFonts.chipTextSize,
      color: LightThemeColors.chipTextColor,
    );
  }

  // elevated button text style
  static MaterialStateProperty<TextStyle?>? getElevatedButtonTextStyle(
      {bool isBold = true, double? fontSize}) {
    return MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              color: LightThemeColors.buttonTextColor);
        } else if (states.contains(MaterialState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: LightThemeColors.buttonDisabledTextColor);
        }
        return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: LightThemeColors.buttonTextColor); // Use the component's default.
      },
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          fixedSize: MaterialStateProperty.all(Size(330.w, 55)),
          elevation: MaterialStateProperty.all(7),
          shadowColor: MaterialStateProperty.all(myBlack),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: getElevatedButtonTextStyle(),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return LightThemeColors.buttonColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return LightThemeColors.buttonDisabledColor;
              }
              return LightThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  static getRadioButtonTheme() => RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(
          LightThemeColors.radioColor,
        ),
      );

  static getDividerTheme() => const DividerThemeData(
        color: LightThemeColors.dividerColor,
      );

  static getDialogTheme() => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      );
  static getCardTheme() => CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  static InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
      );
  static InputDecoration getInputDecoration() => InputDecoration(
        filled: true,
        fillColor: lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: lightGrey, width: 1.5),
        ),
      );
  //*************************** My Custom Styles For a Specific Use Cases  ***********************************

  static ButtonStyle getGreyElevatedButtonStyle() => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xffe7e7e7)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size(330.w, 55)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
        textStyle: MaterialStateProperty.all(
          (MyFonts.bodyTextStyle).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: MyFonts.body1TextSize,
            color: LightThemeColors.bodyTextColor,
          ),
        ),
      );
  static ButtonStyle getSignupWithGoogleButtonStyle() => ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(330.w, 60)),
        backgroundColor: MaterialStateProperty.all(LightThemeColors.scaffoldBackgroundColor),

        /// Splash color
        overlayColor: MaterialStateProperty.all(Colors.grey[200]),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              width: .2.sp,
              color: LightThemeColors.dividerColor,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      );
}
