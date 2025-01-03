import 'package:flutter/material.dart';

class AppTheme {
  static const neonGreen = Color(0xFF00FF94);
  static const darkBackground = Color(0xFF121212);
  
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: neonGreen,
      scaffoldBackgroundColor: darkBackground,
      brightness: Brightness.dark,
      cardTheme: CardTheme(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black87,
        selectedItemColor: neonGreen,
        unselectedItemColor: Colors.white54,
      ),
    );
  }
} 