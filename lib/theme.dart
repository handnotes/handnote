import 'package:flutter/material.dart';

const Color primaryColor = Colors.blueGrey;
final Color secondaryColor = Colors.red[300]!;
final Color disabledColor = Colors.blueGrey[200]!;
final Color errorColor = Colors.red[300]!;
final Color successColor = Colors.green[300]!;

final lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.light,
  backgroundColor: Colors.blueGrey[50],
  hintColor: Colors.grey,
  dividerColor: Colors.grey[200],
  disabledColor: disabledColor,
  colorScheme: const ColorScheme.light().copyWith(
    primary: primaryColor,
    onPrimary: Colors.white,
    primaryContainer: primaryColor,
    onPrimaryContainer: Colors.white,
    secondary: secondaryColor,
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
      side: BorderSide(color: disabledColor),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  dividerColor: Colors.grey[800],
  backgroundColor: Colors.grey[800],
  colorScheme: const ColorScheme.dark().copyWith(
    primary: primaryColor,
    onPrimary: Colors.white,
    primaryContainer: Colors.blueGrey[700],
    onPrimaryContainer: Colors.white,
    secondary: secondaryColor,
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
