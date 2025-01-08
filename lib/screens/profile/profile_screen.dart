import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'achievements_screen.dart';
import 'game_history_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No user data found'));
        }

        final data = snapshot.data!.data();
        if (data == null) {
          return const Center(child: Text('Invalid user data'));
        }

        final userData = UserModel.fromMap(data as Map<String, dynamic>);

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userData.photoUrl != null
                        ? NetworkImage(userData.photoUrl!)
                        : null,
                    child: userData.photoUrl == null
                        ? Text(
                            userData.username[0].toUpperCase(),
                            style: const TextStyle(fontSize: 32),
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userData.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userData.email,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  if (userData.bio != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      userData.bio!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
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
      },
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
      case 'Game History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameHistoryScreen()),
        );
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
      case 'Help & Support':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportScreen()),
        );
    }
  }
} 