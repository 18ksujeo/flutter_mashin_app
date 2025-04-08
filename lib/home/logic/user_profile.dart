class UserProfile {
  final String id;
  final String name;
  final String role;
  final String phone;
  final String bio;
  final String imageUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.phone,
    required this.bio,
    required this.imageUrl,
  });

  // Add method to convert UserProfile to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'phone': phone,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }

  // Add method to create UserProfile from a map
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      phone: map['phone'],
      bio: map['bio'],
      imageUrl: map['imageUrl'],
    );
  }

  static Future<void> fromJson(json) async {}
}