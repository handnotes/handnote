import 'package:flutter/material.dart';

const Color primaryColor = Colors.blueGrey;
final Color secondaryColor = Colors.red[300]!;
final Color errorColor = Colors.red[300]!;
final Color successColor = Colors.green[300]!;

final lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.light,
  primaryColor: Colors.blueGrey,
  backgroundColor: Colors.blueGrey[50],
  hintColor: Colors.grey,
  dividerColor: Colors.grey[200],
  disabledColor: Colors.blueGrey[200],
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.blueGrey,
    secondary: secondaryColor,
    onBackground: Colors.blueGrey,
    onPrimaryContainer: Colors.white,
    onSecondaryContainer: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      primary: errorColor,
      onPrimary: Colors.white,
      elevation: 0,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      side: BorderSide(color: Colors.blueGrey[200]!),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  dividerColor: Colors.grey[800],
  backgroundColor: Colors.grey[800],
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: secondaryColor,
    surface: Colors.grey[800],
    onError: Colors.white,
    onPrimary: Colors.blueGrey[200],
    onPrimaryContainer: Colors.white,
    onSecondaryContainer: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      side: BorderSide(color: Colors.blueGrey[300]!),
      primary: Colors.blueGrey[200],
    ),
  ),
);
