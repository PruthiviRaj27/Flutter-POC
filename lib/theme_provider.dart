import 'package:flutter/material.dart';
import 'package:poc_project/preferences_manager.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = PreferencesManager().isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  Color get background => currentTheme.colorScheme.background;

  Color? get textTitleColour => currentTheme.textTheme.titleLarge?.color;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Define your light theme
  ThemeData get _lightTheme {
    return ThemeData(
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            brightness: Brightness.light),
        textTheme: const TextTheme().copyWith(
          headlineLarge: const TextStyle(color: Colors.black),
          headlineMedium: const TextStyle(color: Colors.black),
          headlineSmall: const TextStyle(color: Colors.black),
          titleLarge: const TextStyle(color: Colors.black),
          titleMedium: const TextStyle(color: Colors.black),
          titleSmall: const TextStyle(color: Colors.black),
          bodySmall: const TextStyle(color: Colors.black),
          bodyMedium: const TextStyle(color: Colors.black),
          bodyLarge: const TextStyle(color: Colors.black),
          labelSmall: const TextStyle(color: Colors.black),
          labelMedium: const TextStyle(color: Colors.black),
          labelLarge: const TextStyle(color: Colors.black),
          displaySmall: const TextStyle(color: Colors.black),
          displayMedium: const TextStyle(color: Colors.black),
          displayLarge: const TextStyle(color: Colors.black),
        ),
        useMaterial3: true);
  }

  // Define your dark theme
  ThemeData get _darkTheme {
    return ThemeData(
        colorScheme: const ColorScheme.light(
            background: Color(0xFF03060B),
            brightness: Brightness.dark),
        textTheme: const TextTheme().copyWith(
          headlineLarge: const TextStyle(color: Colors.white),
          headlineMedium: const TextStyle(color: Colors.white),
          headlineSmall: const TextStyle(color: Colors.white),
          titleLarge: const TextStyle(color: Colors.white),
          titleMedium: const TextStyle(color: Colors.white),
          titleSmall: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          labelSmall: const TextStyle(color: Colors.white),
          labelMedium: const TextStyle(color: Colors.white),
          labelLarge: const TextStyle(color: Colors.white),
          displaySmall: const TextStyle(color: Colors.white),
          displayMedium: const TextStyle(color: Colors.white),
          displayLarge: const TextStyle(color: Colors.white),
        ),
        useMaterial3: true);
  }
}
