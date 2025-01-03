import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'achievements_screen.dart';
import 'game_history_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://placeholder.com/200'),
              ),
              const SizedBox(height: 16),
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '@johndoe',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Games', '23'),
                  _buildStatColumn('Friends', '156'),
                  _buildStatColumn('Groups', '4'),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(context, 'My Achievements', Icons.emoji_events),
              _buildSection(context, 'Game History', Icons.history),
              _buildSection(context, 'Settings', Icons.settings),
              _buildSection(context, 'Help & Support', Icons.help),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.neonGreen),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _handleSection(context, title),
    );
  }

  void _handleSection(BuildContext context, String title) {
    switch (title) {
      case 'My Achievements':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementsScreen()),
        );
        break;
      case 'Game History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameHistoryScreen()),
        );
        break;
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
      case 'Help & Support':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportScreen()),
        );
        break;
    }
  }
} 