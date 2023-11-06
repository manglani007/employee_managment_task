import 'package:employee_managment_task/app/theme/app_color.dart';
import 'package:flutter/material.dart';

class ApplicationTheme {
  static final lightTheme = ThemeData(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(elevation: 0),
      datePickerTheme:
          DatePickerThemeData(dayStyle: TextStyle(fontWeight: FontWeight.w400)),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: primaryColor,
        suffixIconColor: primaryColor,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5E5E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5E5E5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ));
}
