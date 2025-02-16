
import 'package:flutter/material.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outline_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class WNAppTheme{
  WNAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.white,
    textTheme: WNTextTheme.lightTextTheme,
    chipTheme: WNChipTheme.lightChipTheme,
    appBarTheme: WNAppBarTheme.lightAppBarTheme,
    checkboxTheme: WNCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: WNBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: WNElevatedButton.lightElevatedButtonTheme,
    outlinedButtonTheme: WNOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: WNTextFormFieldTheme.lightTextFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.black,
    textTheme: WNTextTheme.darkTextTheme,
    chipTheme: WNChipTheme.darkChipTheme,
    appBarTheme: WNAppBarTheme.darkAppBarTheme,
    checkboxTheme: WNCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: WNBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: WNElevatedButton.darkElevatedButtonTheme,
    outlinedButtonTheme: WNOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: WNTextFormFieldTheme.darkTextFieldTheme,
  );
}
