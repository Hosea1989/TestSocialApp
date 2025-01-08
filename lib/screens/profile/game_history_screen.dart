import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://placeholder.com/100',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Game Title'),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last played: 2 hours ago'),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: AppTheme.neonGreen),
                      SizedBox(width: 4),
                      Text('Total: 48h'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 