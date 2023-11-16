import 'package:flutter/material.dart';

class FlutterOvejaGoTheme {
  FlutterOvejaGoTheme._();

  // If you want to modify both themes at once, modify the colors below.

  static const Color _primaryColor = Color.fromARGB(255, 127, 19, 242);
  static const Color _primaryInverseColor = Color.fromARGB(255, 233, 196, 115);
  static const Color _onSurfaceColor = Color.fromARGB(255, 196, 248, 233);
  static const Color _onSurfaceVariant = Color.fromARGB(255, 230, 244, 46);
  static const Color _onPrimaryColor = Color(0xFFA5E179);
  static const Color _surfaceColor = Color.fromARGB(255, 107, 22, 234);
  static const Color _backgroundColor = Color(0xFF373C4B);
  static const Color _onSecondaryColor = Color(0xFFE1E3E4);
  static const Color _onBackgroundColor = Color(0xFF828A9A);
  static const Color _secondaryColor = Color(0xFF55393D);
  static const Color _primaryContainer = Color(0xFF394634);
  static const Color _errorColor = Color(0xFFF69C5E);
  static const Color _onErrorColor = Color(0xFF354157);

  // If you want to modify the light theme only, modify the colors below.

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: FlutterOvejaGoTheme._primaryColor,
      background: FlutterOvejaGoTheme._backgroundColor,
      primary: FlutterOvejaGoTheme._primaryColor,
      secondary: FlutterOvejaGoTheme._secondaryColor,
      inversePrimary: FlutterOvejaGoTheme._primaryInverseColor,
      onSurface: FlutterOvejaGoTheme._onSurfaceColor,
      surface: FlutterOvejaGoTheme._surfaceColor,
      onSurfaceVariant: FlutterOvejaGoTheme._onSurfaceVariant,
      onPrimary: FlutterOvejaGoTheme._onPrimaryColor,
      onSecondary: FlutterOvejaGoTheme._onSecondaryColor,
      onBackground: FlutterOvejaGoTheme._onBackgroundColor,
      primaryContainer: FlutterOvejaGoTheme._primaryContainer,
      error: FlutterOvejaGoTheme._errorColor,
      onError: FlutterOvejaGoTheme._onErrorColor,
    ),
  );

  // If you want to modify the dark theme only, modify the colors below.

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: FlutterOvejaGoTheme._primaryColor,
      background: FlutterOvejaGoTheme._backgroundColor,
      primary: FlutterOvejaGoTheme._primaryColor,
      secondary: FlutterOvejaGoTheme._secondaryColor,
      inversePrimary: FlutterOvejaGoTheme._primaryInverseColor,
      onSurface: FlutterOvejaGoTheme._onSurfaceColor,
      surface: FlutterOvejaGoTheme._surfaceColor,
      onSurfaceVariant: FlutterOvejaGoTheme._onSurfaceVariant,
      onPrimary: FlutterOvejaGoTheme._onPrimaryColor,
      onSecondary: FlutterOvejaGoTheme._onSecondaryColor,
      onBackground: FlutterOvejaGoTheme._onBackgroundColor,
      primaryContainer: FlutterOvejaGoTheme._primaryContainer,
      error: FlutterOvejaGoTheme._errorColor,
      onError: FlutterOvejaGoTheme._onErrorColor,
    ),
  );
}

// A custom Flutter theme by @navirobayo | Check out FlutterCustomThemesVol1 for more. 
