import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSupportCard(
            'FAQs',
            Icons.question_answer,
            'Find answers to common questions',
            () {},
          ),
          _buildSupportCard(
            'Contact Support',
            Icons.headset_mic,
            'Get help from our support team',
            () {},
          ),
          _buildSupportCard(
            'Report a Bug',
            Icons.bug_report,
            'Help us improve the app',
            () {},
          ),
          _buildSupportCard(
            'Terms of Service',
            Icons.description,
            'Read our terms and conditions',
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.neonGreen),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
} 