class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? photoUrl;
  final List<String> friends;
  final List<String> games;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.photoUrl,
    this.friends = const [],
    this.games = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'friends': friends,
      'games': games,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      friends: List<String>.from(map['friends'] ?? []),
      games: List<String>.from(map['games'] ?? []),
    );
  }
} 