import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GamerSocialApp());
}

class GamerSocialApp extends StatelessWidget {
  const GamerSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamer Social Hub',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
} 