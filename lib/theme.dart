import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueGrey,
  backgroundColor: Colors.blueGrey[50],
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.blueGrey,
    secondary: Colors.red[300],
    onBackground: Colors.blueGrey,
    onPrimaryContainer: Colors.white,
    onSecondaryContainer: Colors.white,
  ),
  hintColor: Colors.grey,
  dividerColor: Colors.grey[200],
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.blueGrey,
    secondary: Colors.red[300],
    surface: Colors.grey[800],
    onPrimaryContainer: Colors.white,
    onSecondaryContainer: Colors.white,
  ),
  dividerColor: Colors.grey[800],
);
