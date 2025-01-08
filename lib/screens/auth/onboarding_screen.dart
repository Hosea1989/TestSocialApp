import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import '../../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String userId;
  final String email;

  const OnboardingScreen({
    super.key,
    required this.userId,
    required this.email,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  final TextEditingController _bioController = TextEditingController();
  final List<String> _selectedConsoles = [];
  final List<String> _selectedGames = [];
  bool _isLoading = false;
  File? _imageFile;
  String? _uploadedImageUrl;

  final List<String> _consoles = [
    'PlayStation 5',
    'PlayStation 4',
    'Xbox Series X/S',
    'Xbox One',
    'Nintendo Switch',
    'PC',
    'Mobile',
  ];

  final Map<String, List<String>> _gamesByPlatform = {
    'PlayStation': ['God of War', 'Spider-Man', 'The Last of Us', 'Horizon'],
    'Xbox': ['Halo', 'Gears of War', 'Forza', 'Sea of Thieves'],
    'Nintendo': ['Mario', 'Zelda', 'Pokemon', 'Animal Crossing'],
    'PC': ['Valorant', 'League of Legends', 'World of Warcraft', 'Counter-Strike'],
    'Mobile': ['PUBG Mobile', 'Genshin Impact', 'Clash Royale', 'Among Us'],
    'Cross-Platform': ['Fortnite', 'Minecraft', 'Rocket League', 'Call of Duty'],
  };

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.email.split('@')[0],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_photos')
          .child('${widget.userId}.jpg');

      await ref.putFile(_imageFile!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Complete Your Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null 
                          ? FileImage(_imageFile!) 
                          : null,
                      child: _imageFile == null
                          ? const Icon(Icons.add_a_photo, size: 40)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                    hintText: 'Tell us about yourself...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                const Text(
                  'What do you play on?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _consoles.map((console) {
                    final isSelected = _selectedConsoles.contains(console);
                    return FilterChip(
                      label: Text(console),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedConsoles.add(console);
                          } else {
                            _selectedConsoles.remove(console);
                          }
                        });
                      },
                      selectedColor: AppTheme.neonGreen,
                      checkmarkColor: Colors.black,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                if (_selectedConsoles.isNotEmpty) ...[
                  const Text(
                    'Select your favorite games:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _gamesByPlatform.entries
                        .expand((entry) => entry.value)
                        .toSet()
                        .map((game) {
                      final isSelected = _selectedGames.contains(game);
                      return FilterChip(
                        label: Text(game),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedGames.add(game);
                            } else {
                              _selectedGames.remove(game);
                            }
                          });
                        },
                        selectedColor: AppTheme.neonGreen,
                        checkmarkColor: Colors.black,
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleComplete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.neonGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Complete Profile',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleComplete() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // Upload image if selected
        if (_imageFile != null) {
          _uploadedImageUrl = await _uploadImage();
        }

        final user = UserModel(
          uid: widget.userId,
          username: _usernameController.text,
          email: widget.email,
          photoUrl: _uploadedImageUrl,
          bio: _bioController.text,
          consoles: _selectedConsoles,
          games: _selectedGames,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .set(user.toMap());

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
} 