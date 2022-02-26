import 'package:flutter/material.dart';

const Color primaryColor = Colors.blueGrey;
final Color secondaryColor = Colors.red[300]!;
final Color disabledColor = Colors.blueGrey[200]!;
final Color errorColor = Colors.red[300]!;
final Color successColor = Colors.green[300]!;
final Color darkTextColor = Colors.grey[100]!;

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
    onSecondary: Colors.white,
    secondaryContainer: secondaryColor,
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
    onPrimary: darkTextColor,
    primaryContainer: Colors.grey[800],
    onPrimaryContainer: Colors.grey[300],
    secondary: secondaryColor,
    onSecondary: darkTextColor,
    secondaryContainer: secondaryColor.withOpacity(0.7),
    onSecondaryContainer: darkTextColor,
    surface: Colors.grey[800],
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[800],
  ),
  textTheme: const TextTheme().apply(
    bodyColor: darkTextColor,
    // displayColor: darkTextColor,
    // decorationColor: darkTextColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor.withOpacity(0.7),
      onPrimary: darkTextColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
