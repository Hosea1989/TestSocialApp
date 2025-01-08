class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? photoUrl;
  final String? bio;
  final List<String> consoles;
  final List<String> games;
  final List<String> friends;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.photoUrl,
    this.bio,
    this.consoles = const [],
    this.games = const [],
    this.friends = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'consoles': consoles,
      'games': games,
      'friends': friends,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      bio: map['bio'],
      consoles: List<String>.from(map['consoles'] ?? []),
      games: List<String>.from(map['games'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
    );
  }
} 