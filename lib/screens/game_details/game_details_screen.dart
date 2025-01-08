import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GameDetails extends StatelessWidget {
  final String title;
  final String imageUrl;

  const GameDetails({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Game title and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: AppTheme.neonGreen),
                          Text('4.5'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Upload video section
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.video_call, color: AppTheme.neonGreen),
                      title: const Text('Upload Gameplay'),
                      subtitle: const Text('Share your gaming moments'),
                      onTap: () {
                        // Implement video upload
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Where to buy section
                  const Text(
                    'Where to Buy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildStoreCard(
                    'Steam',
                    Icons.games,
                    '\$59.99',
                    () {},
                  ),
                  _buildStoreCard(
                    'Epic Games',
                    Icons.gamepad,
                    '\$54.99',
                    () {},
                  ),
                  _buildStoreCard(
                    'PlayStation Store',
                    Icons.sports_esports,
                    '\$59.99',
                    () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(
    String store,
    IconData icon,
    String price,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(store),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: AppTheme.neonGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 