import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Achievements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.emoji_events,
                color: AppTheme.neonGreen,
                size: 32,
              ),
              title: Text('Achievement ${index + 1}'),
              subtitle: const Text('Unlocked on 2024-03-15'),
              trailing: const CircleAvatar(
                backgroundColor: AppTheme.neonGreen,
                child: Text('✓', style: TextStyle(color: Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
} 