import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.blueGrey,
    secondary: Colors.red[300],
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
  ),
  hintColor: Colors.grey,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.blueGrey,
    secondary: Colors.red[300],
    surface: Colors.grey[800],
  ),
  textTheme: const TextTheme(),
);
